<?php // $Id: node.tpl.php,v 1.5 2009/11/03 22:22:04 jmburnz Exp $ 

/**
 * @file node.tpl.php
 *
 * Theme implementation to display a node.
 *
 * @see template_preprocess()
 * @see template_preprocess_node()
 */
?>
<div id="node-<?php print $node->nid; ?>" class="node <?php print $node_classes; ?>">

  <?php if (!$page): ?>	
    <h2><a href="<?php print $node_url; ?>" rel="bookmark"><?php print $title; ?></a></h2>
  <?php endif; ?>
	
  <?php if ($unpublished): ?>
    <div class="unpublished"><?php print t('Unpublished'); ?></div>
  <?php endif; ?>

  <?php if ($submitted): ?>
    <h3 class="meta">
      <abbr title="<?php print format_date($node->created, 'custom', "l, F j, Y - H:i"); ?>">
        <?php print format_date($node->created, 'custom', "F j, Y"); ?>
      </abbr>
      <?php print t('by'); ?> <em><?php print $name; ?></em>
    </h3>
  <?php endif; ?>

  <?php if ($node->type != 'poll'): ?>
    <?php print $picture; ?>
  <?php endif; ?>

  <?php print $content; ?>

  <?php if ($terms): ?>
    <div class="tags"><?php print $terms; ?></div>
  <?php endif; ?>
  
  <?php if ($links): ?>
    <div class="actions"><?php print $links; ?></div>
  <?php endif; ?>
 
  <?php if ($node_region && $page): ?>
    <div class="node-region"><?php print $node_region; ?></div>
  <?php endif; ?>

</div> <!-- /node -->