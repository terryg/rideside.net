<?php // $Id: block.tpl.php,v 1.3 2009/11/02 12:03:18 jmburnz Exp $
/**
 * @file block.tpl.php
 *
 * Theme implementation to display a block.
 *
 * @see template_preprocess()
 * @see template_preprocess_block()
 */
?>
<div id="block-<?php print $block->module .'-'. $block->delta; ?>" class="block <?php print $block_classes .' '. $skinr; ?>">
  <div class="block-wrapper">
    <?php if ($block->subject): ?>
      <h2 class="title"><span><?php print $block->subject; ?></span></h2>
    <?php endif; ?>
    <div class="content">
      <?php print $block->content; ?>
    </div>
  </div>
</div> <!-- /block -->
