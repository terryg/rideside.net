<?php
/**
 * Ubiquity Drupal theme page.tpl.php file
 */
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="<?php print $language->language ?>" xml:lang="<?php print $language->language ?>">
<head>
  <title><?php print $head_title; ?></title>
  <?php print $head; ?>
  <?php print $styles; ?>
  <!--[if lt IE 7]>
    <?php print ubiquity_get_ie_stylesheets(); ?>
  <![endif]-->
  <?php print $scripts; ?>
</head>

<body class="<?php print $body_classes; ?>">

<div id="page">
  <div id="container">

    <div id="header">

      <div id="header-inner">

      <?php if ($logo): ?>
        <a href="<?php print $base_path; ?>" title="<?php print t('Home'); ?>">
          <img src="<?php print $logo; ?>" alt="<?php print t('Home'); ?>" id="logo" />
        </a>
      <?php endif; ?>

      <?php if ($site_name || $site_slogan): ?><div id="name-and-slogan"><?php endif; ?>
        <?php if ($site_name): ?>
          <h1 id="site-name">
            <a href="<?php print $base_path ?>" title="<?php print t('Home'); ?>">
              <?php print $site_name; ?>
            </a>
          </h1>
        <?php endif; ?>

      <?php if ($site_slogan): ?>
        <div id="site-slogan"><?php print $site_slogan; ?></div>
      <?php endif; ?>
      <?php if ($site_name || $site_slogan): ?></div><?php endif; ?>

      <?php if ($header):?><div id="header-region"><?php print $header; ?></div><?php endif; ?>

      </div>

      <?php if ($primary_links): ?>
      <div id="navigation">
          <?php if ($primary_links): ?>
            <div id="primary" class="clear-block">
              <?php print theme('links', $primary_links); ?>
            </div>
          <?php endif; ?>
          <?php if ($secondary_links): ?>
            <div id="secondary" class="clear-block">
              <?php print theme('links', $secondary_links); ?>
            </div>
          <?php endif; ?>

      </div> <!-- /navigation -->
      <?php endif; ?>

      <?php print $search_box; ?>

    </div>

    <div id="wrapper">

      <div id="wrapper-main">

        <div id="main">
          <div id="main-inner">
          <?php if ($breadcrumb): print $breadcrumb; endif; ?>

          <?php if ($mission): ?><div id="mission"><?php print $mission; ?></div><?php endif; ?>
          <?php if ($content_top):?><div id="content-top"><?php print $content_top; ?></div><?php endif; ?>
          <?php if ($title): ?><h1 class="title"><?php print $title; ?></h1><?php endif; ?>
          <?php if ($tabs): ?><div class="tabs"><?php print $tabs; ?><div class="clear zero"></div></div><div class="clear zero"></div><?php endif; ?>
          <?php if (isset($tabs2)): ?><div class="tabs-sec"><?php print $tabs2; ?></div><br class="clear" /><?php endif; ?>
          <?php print $help; ?>
          <?php print $messages; ?>
          <?php print $content; ?>
          <?php print $feed_icons; ?>
          <?php if ($content_bottom): ?><div id="content-bottom"><?php print $content_bottom; ?></div><?php endif; ?>

          </div>
        </div>

      </div> <!-- /wrapper -->

      <?php if ($left): ?>
        <div id="sidebar-left" class="column sidebar">
          <div id="sidebar-left-inner">
          <?php print $left; ?>
          </div>
        </div>
      <?php endif; ?>

      <?php if ($right): ?>
        <div id="sidebar-right" class="column sidebar">
          <div id="sidebar-right-inner">
            <?php print $right; ?>
          </div>
        </div>
      <?php endif; ?>

    </div>

      <div id="footer">
        <div id="footer-inner">
        <?php print $footer; ?>
        <?php print $footer_message; ?>
        </div>
      </div>

  </div>
</div>

  <?php print $closure; ?>

</body>
</html>
