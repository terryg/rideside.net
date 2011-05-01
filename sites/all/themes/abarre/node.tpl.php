<?php 
// $Id: node.tpl.php,v 1.1.4.5 2008/08/03 22:37:17 couzinhub Exp $
?>
<div class="node" id="node-<?php print $node->nid; ?>">
	  <?php if ($page == 0): ?>
	    <h2 class="title">
	      <a href="<?php print $node_url ?>"><?php print $title; ?></a>
	    </h2>
	  <?php endif; ?>

	  <?php if ($submitted): ?>
			<div class="submitted"><?php print t('Posted on ') . format_date($node->created, 'custom', 'F jS, Y') . t(' by ') .  $picture . theme('username', $node); ?></div>
	  <?php endif; ?>

	  <?php if (count($taxonomy)): ?>
	    <div class="taxonomy"><?php print t(' in ') . $terms ?></div>
	  <?php endif; ?>

	  <div class="content">
	    <?php print $content; ?>
	  </div>

	  <?php if ($links): ?>
	    <div class="links">
	      <?php print $links; ?>
	    </div>
	  <?php endif; ?>

	</div>
