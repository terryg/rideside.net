<?php // $Id: page.tpl.php,v 1.11 2009/11/04 04:44:06 jmburnz Exp $ 
/**
 * @file page.tpl.php
 *
 * Theme implementation to display a single Drupal page.
 *
 * @see template_preprocess()
 * @see template_preprocess_page()
 */
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="<?php print $language->language; ?>" xml:lang="<?php print $language->language; ?>">
<head>
  <title><?php print $head_title; ?></title>
  <?php print $head; ?>
  <?php print $styles; ?>
  <!--[if lte IE 7]>
    <link rel="stylesheet" href="<?php print $base_path . $directory; ?>/ie.css" type="text/css">
  <![endif]-->
  <?php if (!empty($suckerfish)): ?>
  <!--[if lte IE 7]>
    <script type="text/javascript" src="<?php print $base_path . $directory; ?>/js/suckerfish.js"></script>
  <![endif]-->
   <?php endif; ?>
  <?php print $scripts; ?>
</head>
<body class="<?php print newswire_column_count_class($left, $content, $right, $right_2) . $body_class; ?>">
  <div id="container">

    <div id="accessiblity" class="width-48-950 last nofloat">
      <a href="#content"><?php print t('Skip to main content'); ?></a>
    </div>

    <?php if ($leaderboard): ?>
      <div id="leaderboard" class="width-48-950 last nofloat">
       <?php print $leaderboard; ?>
      </div> <!-- /leaderboard -->
    <?php endif; ?>

    <?php if ($logo || $site_name || $site_slogan || $search_box): ?>
      <div id="header" class="width-48-950 last nofloat clearfix">				
        <?php if ($logo || $site_name || $site_slogan): ?>
          <div class="branding width-30-590">
            <?php if ($logo) { print $logo; } else { print $site_name; } ?>        
            <?php if ($site_slogan): ?>
              <em><?php print $site_slogan; ?></em>
            <?php endif; ?>
          </div> <!-- /branding -->
        <?php endif; ?>

        <?php if ($search_box): ?>
          <div id="search-box-top" class="width-18-350 last">
            <?php print $search_box; ?>
          </div> <!-- /search -->
        <?php endif; ?>
				
      </div> <!-- /header -->
    <?php endif; ?>

    <div id="main-navigation" class="width-48-950 last nofloat clearfix">
      <?php if ($primary_links || $suckerfish): ?>
        <div id="<?php print $primary_links ? 'primary-menu' : 'suckerfish' ; ?>" class="width-45-890">
          <?php if ($primary_links) { print theme('links', $primary_links, array('class' => 'primary-links clearfix')); } elseif (!empty($suckerfish)) { print $suckerfish; } ?>
        </div> <!-- /primary -->
      <?php endif; ?>
      <div class="feed-icons clearfix">
        <a href="<?php print $base_path; ?>rss.xml" class="feed-icon">
          <img src="<?php print $base_path . $directory; ?>/images/feed.png" alt="Syndicate content" title="RSS Feed" width="16" height="16" />
        </a> 
      </div> <!-- /rss icon -->
    </div>

    <?php if ($secondary_links): ?> 
      <div id="secondary-menu" class="width-48-950 last nofloat">
        <?php print theme('links', $secondary_links, array('class' => 'secondary-links clearfix')); ?>
      </div>
    <?php endif; ?>
    
    <?php if ($messages || $help): ?>
      <div id="messages">
        <?php print $messages; ?>
        <?php print $help; ?> 
      </div>
    <?php endif; ?>

    <?php if ($header): ?>
      <div id="header" class="width-48-950 last nofloat">
        <?php print $header; ?>
      </div> <!-- /header -->
    <?php endif; ?>

    <?php if ($content_top_full_width || $content_top_left || $content_top_content): ?>
      <div id="content-top" class="width-48-950 last nofloat">	
        <?php if ($content_top_full_width): ?>
          <div id="content-top-full-width" class="width-48-950 last nofloat">
            <?php print $content_top_full_width; ?>
          </div> <!-- /full-width -->
        <?php endif; ?>			
        <?php if ($content_top_left): ?>
          <div class="content-top-col-1 width-24-470">
            <?php print $content_top_left; ?>
          </div> <!-- /top-left -->
        <?php endif; ?>
        <?php if ($content_top_right): ?>
          <div class="content-top-col-2 width-24-470 last">
            <?php print $content_top_right; ?>
          </div> <!-- /top-right -->
        <?php endif; ?>
      </div> <!-- /content-top -->
    <?php endif; ?>

    <div id="col_wrapper" class="width-960">
    
      <?php if ($left): ?>
        <div id="left" class="width-10-190">
          <?php print $left; ?>
        </div> <!-- /left -->
      <?php endif; ?>

      <div id="content" class="<?php print newswire_col_width($left, $content, $right, $right_2); ?>">
        
        <?php if ($main_content_top): ?>
          <div id="main-content-top">
            <?php print $main_content_top; ?>
          </div>
        <?php endif; ?>
			
        <?php print $breadcrumb; ?>

        <?php if ($title): ?><?php print $title; ?><?php endif; ?>					
        <?php if ($tabs): ?><div class="tabs"><?php print $tabs; ?></div><?php endif; ?>   					
        <?php if ($mission): ?><div class="mission"><?php print $mission; ?></div><?php endif; ?>
	
        <?php print $content; ?> 

        <?php if ($main_content_bottom): ?>
          <div id="main-content-bottom">
            <?php print $main_content_bottom; ?>
          </div>
        <?php endif; ?>

      </div> <!-- /content -->

      <?php if (($right_top_box || $right_bottom_box) && ($right_2 && $right)): ?>
        <div id="right-col-wrapper" class="width-20-390 last">
          
          <?php if (($right_top_box) && ($right_2 && $right)): ?>
            <div id="right-top-box" class="width-20-390 last nofloat">
              <?php print $right_top_box; ?>
            </div> <!-- /right top box -->
          <?php endif; ?>
          
        <?php endif; ?>

          <?php if ($right_2): ?>
            <div id="right_2" class="width-10-190">
              <?php print $right_2; ?>
            </div> <!-- /right 2 -->
          <?php endif; ?>

          <?php if ($right): ?>
            <div id="right" class="width-10-190 last">
              <?php print $right; ?>
            </div> <!-- /right -->
          <?php endif; ?>

          <?php if (($right_bottom_box) && ($right_2 && $right)): ?>
            <div id="right-bottom-box" class="width-20-390 last nofloat">
              <?php print $right_bottom_box; ?>
            </div> <!-- /right bottom box -->
          <?php endif; ?>
	
        <?php if (($right_top_box || $right_bottom_box) && ($right_2 && $right)): ?>
          </div> <!-- /right col wrapper -->
        <?php endif; ?>

    </div> <!-- /col_wrapper-->

    <?php if ($content_bottom_full_width || $content_bottom_left || $content_bottom_right): ?>
      <div id="content-bottom" class="width-48-950 last nofloat">
        <?php if ($content_bottom_left): ?>
          <div class="content-bottom-col-1 width-24-470">
            <?php print $content_bottom_left; ?>
          </div> <!-- /bottom-left -->
        <?php endif; ?>
        <?php if ($content_bottom_right): ?>
          <div class="content-bottom-col-2 width-24-470 last">
            <?php print $content_bottom_right; ?>
          </div> <!-- /bottom-right -->
        <?php endif; ?>
        <?php if ($content_bottom_full_width): ?>
          <div id="content-bottom-full-width" class="width-48-950 last nofloat">
            <?php print $content_bottom_full_width; ?>
          </div> <!-- /bottom-full-width -->
        <?php endif; ?>
      </div> <!-- /content-bottom -->
    <?php endif; ?>

    <?php if ($footer): ?>
      <div id="footer" class="width-48-950 last nofloat">
        <?php print $footer; ?>
      </div>  <!-- /footer -->
    <?php endif; ?>

    <?php if ($footer_message): ?>
      <div id="footer-message" class="width-48-950 last nofloat small">
        <?php print $footer_message ?>
      </div>  <!-- /footer message -->
    <?php endif; ?>
    
    <?php // You are free to remove the attribution, this is hidden by default with CSS so it won't disturb your theme. ?>
    <div class="element-invisible"><a href="http://adaptivethemes.com">Premium Drupal Themes by Adaptivethemes</a></div>
    
    <?php print $closure ?>

  </div> <!-- /container -->
</body>
</html>
