<?php
/**
 * Ubiquity Drupal theme comment.tpl.php file
 */
?><div class="comment<?php if ($comment->status == COMMENT_NOT_PUBLISHED) print ' comment-unpublished'; ?>">
  <div class="submitted"><?php print t('On ') . format_date($comment->timestamp, 'custom', 'G:ia, F jS, Y'); ?> <?php print theme('username', $comment) . t(' said'); ?>:</div>
  <?php if ($new != '') { ?><span class="new"><?php print $new; ?></span><?php } ?><h3 class="title" title="<?php print t('Permalink'); ?>"><?php print $title; ?></h3>

    <div class="content"><div class="content-inner"><?php if ($picture): ?><div class="picture"><?php print $picture; ?></div><?php endif; ?><?php print $content; ?></div></div>
    <div class="links"><?php print $links; ?></div>
</div>
