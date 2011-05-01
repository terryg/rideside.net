<?php // $Id: comment-wrapper.tpl.php,v 1.3 2009/11/02 12:03:18 jmburnz Exp $
/**
 * @file comment-wrapper.tpl.php
 *
 * Theme implementation to wrap comments.
 *
 * @see template_preprocess_comment_wrapper()
 * @see theme_comment_wrapper()
 */
?>
<div id="comments">
  <?php if (!empty($content)): ?>
    <h2 id="comments-title"<?php if ($node->type == 'forum') { print ' class="element-invisible"'; } ?>>
      <?php print t('Comments'); ?>
    </h2>
    <?php print $content; ?>
  <?php endif; ?>
</div>
