<?php 
// $Id: page.tpl.php,v 1.1.4.5 2008/08/03 20:07:46 couzinhub Exp $
?>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php print $language->language ?>" lang="<?php print $language->language ?>" dir="<?php print $language->dir ?>">

<head>
  <title><?php print $head_title; ?></title>
  <?php print $head; ?>
  <?php print $styles; ?>
  <?php print $scripts; ?>
	<!--[if lte IE 6]>
	  <style type="text/css" media="all">@import "<?php print base_path() . path_to_theme() ?>/css/ie6.css";</style>
	<![endif]-->
	<!--[if IE 7]>
  	<style type="text/css" media="all">@import "<?php print base_path() . path_to_theme() ?>/css/ie7.css";</style>
	<![endif]-->

</head>

<body class="<?php print $body_classes; ?>">
  <?php if ($tabs): ?><div class="tabs"><?php print $tabs; ?></div><?php endif; ?>

    <div id="header">

        <?php if ($logo): ?>
          <a href="<?php print $base_path; ?>" title="<?php print t('Home'); ?>">
            <img src="<?php print $logo; ?>" alt="<?php print t('Home'); ?>" id="logo" />
          </a>
        <?php endif; ?>
        
        <?php if ($site_name): ?>
          <h1 id='site-name'>
            <a href="<?php print $base_path ?>" title="<?php print t('Home'); ?>">
              <?php print $site_name; ?>
            </a>
          </h1>
        <?php endif; ?>
        
        <?php if ($site_slogan): ?>
          <div id='site-slogan'>
            <?php print $site_slogan; ?>
          </div>
        <?php endif; ?>
        
				<div class="clear-block"></div>

        <?php print $search_box; ?>      

    </div> <!-- /header -->

    <div id="main">
			<div id="content" class="column">
      	<?php if ($mission): ?><div id="mission"><?php print $mission; ?></div><?php endif; ?>
      	<?php print $feed_icons; ?>
	      <?php if ($breadcrumb): ?><?php print $breadcrumb; ?><?php endif; ?>
      	<?php if ($content_top):?><?php print $content_top; ?><?php endif; ?>
      	<?php if ($title): ?><h1 class="title"><?php print $title; ?></h1><?php endif; ?>
      	<?php print $help; ?>
      	<?php print $messages; ?>
      	<?php print $content; ?>
      	<?php if ($content_bottom): ?><?php print $content_bottom; ?><?php endif; ?>
	    </div> <!-- /content -->

      <div id="sidebar-left" class="column">
	
        <?php if (isset($primary_links)) : ?>
	        <?php print theme('links', $primary_links, array('class' => 'links primary-links')); ?>
        <?php endif; ?>

				<?php if (isset($secondary_links)): ?>
           <?php print theme('links', $secondary_links, array('class' => 'links secondary-links')); ?>
        <?php endif; ?>

          <?php print $sidebar_left; ?>

        </div> <!-- /sidebar-left -->

	    </div> <!-- /main -->

      <div id="footer">
				<div id="corner"></div>
				<div class="content">
        	<?php print $footer_message; ?>
 				</div>
     </div> <!-- /footer -->

    <?php print $closure; ?>

</body>
</html>