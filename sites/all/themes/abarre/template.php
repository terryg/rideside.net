<?php 
// $Id: template.php,v 1.1.4.4 2008/08/03 20:08:43 couzinhub Exp $

/**
* Override or insert PHPTemplate variables into the templates.
*/

function phptemplate_preprocess_page(&$vars) {
  // Hook into color.module
  if (module_exists('color')) {
    _color_page_alter($vars);
  }
}
