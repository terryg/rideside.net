<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="<?php print $language->language ?>" xml:lang="<?php print $language->language ?>">
<head>
  <title><?php print $head_title; ?></title>
  <?php print $head; ?>
  <link type="text/css" rel="stylesheet" media="all" href="<?php print base_path() . path_to_theme(); ?>/maintenance.css" />
  <script type="text/javascript"><?php /* Needed to avoid Flash of Unstyled Content in IE */ ?> </script>
</head>
<body>
  <div id="content">
    <?php print check_markup($content); ?>
  </div>
</body>
</html>
