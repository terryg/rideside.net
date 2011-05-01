<?php 
// $Id: comment.tpl.php,v 1.1.4.4 2008/08/03 20:07:46 couzinhub Exp $
?>
<div class="comment<?php if ($comment->status == COMMENT_NOT_PUBLISHED) print ' comment-unpublished'; ?>">
<?php if ($new != '') { ?><span class="new"><?php print $new; ?></span><?php } ?>

	<h3 class="title">
	<?php if ($new): ?>
  	<span class="new"><?php print $new; ?></span>
	<?php endif; ?>
  <?php print $title; ?></h3>
	  
	<div class="submitted"><?php print t('Posted on ') . format_date($comment->timestamp, 'custom', 'F jS, Y') . t(' by ') .  $picture . theme('username', $comment); ?></div>
  
	<div class="content"><?php print $content; ?></div>

	<div class="links"><?php print $links; ?></div>

</div>
