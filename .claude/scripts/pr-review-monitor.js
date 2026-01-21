#!/usr/bin/env node

/**
 * Monitor a GitHub PR for review comments and capture screenshots when they appear
 * Usage: node pr-review-monitor.js <PR_URL>
 */

import { exec } from 'child_process';
import { promisify } from 'util';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const execAsync = promisify(exec);
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const POLL_INTERVAL = 3 * 60 * 1000; // 3 minutes
const MAX_POLLS = 20; // Max 1 hour of polling (20 * 3 min)

async function extractPRNumber(prUrl) {
  // Extract PR number from URL like https://github.com/owner/repo/pull/123
  const match = prUrl.match(/\/pull\/(\d+)/);
  return match ? match[1] : null;
}

async function checkForReviews(prNumber) {
  try {
    // Check for review comments using gh CLI
    const { stdout: reviewsOutput } = await execAsync(`gh pr view ${prNumber} --json reviews`);
    const reviewsData = JSON.parse(reviewsOutput);

    const { stdout: commentsOutput } = await execAsync(`gh pr view ${prNumber} --json comments`);
    const commentsData = JSON.parse(commentsOutput);

    const hasReviews = reviewsData.reviews && reviewsData.reviews.length > 0;
    const hasComments = commentsData.comments && commentsData.comments.length > 0;

    return {
      hasReviews,
      hasComments,
      reviewCount: reviewsData.reviews?.length || 0,
      commentCount: commentsData.comments?.length || 0
    };
  } catch (error) {
    console.error('Error checking for reviews:', error.message);
    return { hasReviews: false, hasComments: false, reviewCount: 0, commentCount: 0 };
  }
}

async function captureScreenshots(prUrl, outputDir) {
  try {
    const scriptPath = join(__dirname, 'capture-pr-screenshots.js');
    const { stdout, stderr } = await execAsync(`node "${scriptPath}" "${prUrl}" "${outputDir}"`);

    if (stdout) console.log(stdout);
    if (stderr) console.error(stderr);

    return true;
  } catch (error) {
    console.error('Error capturing screenshots:', error.message);
    return false;
  }
}

async function monitorPR(prUrl) {
  console.log(`\nStarting PR review monitor for: ${prUrl}`);
  console.log(`Polling every ${POLL_INTERVAL / 60000} minutes for up to ${MAX_POLLS * POLL_INTERVAL / 60000} minutes\n`);

  const prNumber = await extractPRNumber(prUrl);
  if (!prNumber) {
    console.error('Could not extract PR number from URL');
    process.exit(1);
  }

  // Determine output directory (go up from scripts dir to .claude/codereview)
  const outputDir = join(dirname(__dirname), 'codereview');
  console.log(`Screenshots will be saved to: ${outputDir}\n`);

  let pollCount = 0;
  let lastReviewCount = 0;
  let lastCommentCount = 0;

  const pollInterval = setInterval(async () => {
    pollCount++;
    console.log(`[Poll ${pollCount}/${MAX_POLLS}] Checking for reviews at ${new Date().toLocaleTimeString()}...`);

    const status = await checkForReviews(prNumber);

    if (status.hasReviews || status.hasComments) {
      // Check if there are new reviews or comments
      if (status.reviewCount > lastReviewCount || status.commentCount > lastCommentCount) {
        console.log(`\n🎉 New reviews/comments detected!`);
        console.log(`   Reviews: ${status.reviewCount} (was ${lastReviewCount})`);
        console.log(`   Comments: ${status.commentCount} (was ${lastCommentCount})`);
        console.log(`\n📸 Capturing screenshots...\n`);

        const success = await captureScreenshots(prUrl, outputDir);

        if (success) {
          console.log(`\n✓ Screenshots saved to: ${outputDir}`);
          console.log(`\n📋 Next steps:`);
          console.log(`   1. Review the screenshots in ${outputDir}`);
          console.log(`   2. Analyze which comments make sense to address`);
          console.log(`   3. Make code changes to address valid feedback`);
          console.log(`   4. Commit and push changes`);
          console.log(`   5. Clean up screenshots: rm -rf ${outputDir}/*.png`);
          console.log(`   6. Request re-review: gh pr comment ${prUrl} --body "@devai review"\n`);
        }

        lastReviewCount = status.reviewCount;
        lastCommentCount = status.commentCount;
      } else {
        console.log(`   No new reviews (${status.reviewCount} reviews, ${status.commentCount} comments)`);
      }
    } else {
      console.log('   No reviews yet, will check again...');
    }

    if (pollCount >= MAX_POLLS) {
      console.log(`\n⏰ Reached maximum polling attempts (${MAX_POLLS})`);
      console.log('Stopping monitor. You can restart it manually if needed.');
      clearInterval(pollInterval);
      process.exit(0);
    }
  }, POLL_INTERVAL);

  // Initial check immediately
  console.log('[Initial check] Checking current status...');
  const initialStatus = await checkForReviews(prNumber);
  if (initialStatus.hasReviews || initialStatus.hasComments) {
    console.log(`Found existing reviews/comments: ${initialStatus.reviewCount} reviews, ${initialStatus.commentCount} comments`);
    console.log('Capturing initial screenshots...\n');
    await captureScreenshots(prUrl, outputDir);
    lastReviewCount = initialStatus.reviewCount;
    lastCommentCount = initialStatus.commentCount;
  } else {
    console.log('No reviews yet. Starting periodic checks...\n');
  }

  // Handle graceful shutdown
  process.on('SIGINT', () => {
    console.log('\n\nStopping PR monitor...');
    clearInterval(pollInterval);
    process.exit(0);
  });
}

// Main execution
const args = process.argv.slice(2);
if (args.length < 1) {
  console.error('Usage: node pr-review-monitor.js <PR_URL>');
  console.error('Example: node pr-review-monitor.js https://github.com/owner/repo/pull/123');
  process.exit(1);
}

const prUrl = args[0];
monitorPR(prUrl).catch((error) => {
  console.error('Monitor failed:', error);
  process.exit(1);
});
