#!/usr/bin/env node

/**
 * Capture screenshots of GitHub PR review comments
 * Usage: node capture-pr-screenshots.js <PR_URL> <output_dir>
 */

import { chromium } from 'playwright';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { existsSync, mkdirSync } from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

async function captureReviewScreenshots(prUrl, outputDir) {
  console.log(`Capturing screenshots for PR: ${prUrl}`);
  console.log(`Output directory: ${outputDir}`);

  // Ensure output directory exists
  if (!existsSync(outputDir)) {
    mkdirSync(outputDir, { recursive: true });
  }

  const browser = await chromium.launch({
    headless: true
  });

  try {
    const context = await browser.newContext({
      viewport: { width: 1920, height: 1080 }
    });

    const page = await context.newPage();

    // Navigate to PR page
    await page.goto(prUrl, { waitUntil: 'networkidle' });

    // Wait a bit for all content to load
    await page.waitForTimeout(2000);

    // Click on "Files changed" tab to see review comments
    const filesTab = page.locator('a[data-tab-item="pr-files-tab"], button:has-text("Files changed")').first();
    if (await filesTab.count() > 0) {
      await filesTab.click();
      await page.waitForTimeout(2000);
    }

    // Capture full page screenshot
    const timestamp = Date.now();
    const fullPagePath = join(outputDir, `pr-full-page-${timestamp}.png`);
    await page.screenshot({
      path: fullPagePath,
      fullPage: true
    });
    console.log(`✓ Captured full page: ${fullPagePath}`);

    // Find all review comment threads
    const reviewComments = await page.locator('[data-review-comment-id], .review-comment, .timeline-comment').all();

    if (reviewComments.length > 0) {
      console.log(`Found ${reviewComments.length} review comment elements`);

      for (let i = 0; i < Math.min(reviewComments.length, 20); i++) {
        try {
          await reviewComments[i].scrollIntoViewIfNeeded();
          await page.waitForTimeout(500);

          const commentPath = join(outputDir, `review-comment-${i + 1}-${timestamp}.png`);
          await reviewComments[i].screenshot({ path: commentPath });
          console.log(`✓ Captured review comment ${i + 1}: ${commentPath}`);
        } catch (err) {
          console.log(`  ⚠ Could not capture comment ${i + 1}: ${err.message}`);
        }
      }
    } else {
      console.log('No review comments found yet');
    }

    // Also capture the conversation tab
    const conversationTab = page.locator('a[data-tab-item="pr-conversation-tab"], button:has-text("Conversation")').first();
    if (await conversationTab.count() > 0) {
      await conversationTab.click();
      await page.waitForTimeout(2000);

      const conversationPath = join(outputDir, `pr-conversation-${timestamp}.png`);
      await page.screenshot({
        path: conversationPath,
        fullPage: true
      });
      console.log(`✓ Captured conversation tab: ${conversationPath}`);
    }

  } catch (error) {
    console.error('Error capturing screenshots:', error);
    throw error;
  } finally {
    await browser.close();
  }
}

// Main execution
const args = process.argv.slice(2);
if (args.length < 2) {
  console.error('Usage: node capture-pr-screenshots.js <PR_URL> <output_dir>');
  process.exit(1);
}

const [prUrl, outputDir] = args;

captureReviewScreenshots(prUrl, outputDir)
  .then(() => {
    console.log('\n✓ Screenshot capture completed');
    process.exit(0);
  })
  .catch((error) => {
    console.error('\n✗ Screenshot capture failed:', error);
    process.exit(1);
  });
