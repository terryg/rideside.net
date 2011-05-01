<?php // $Id: theme-settings.php,v 1.4 2009/11/03 22:22:04 jmburnz Exp $

/**
 * @file theme-settings.php
 */

/**
* Implementation of THEMEHOOK_settings() function.
*
* @param $saved_settings
*   array An array of saved settings for this theme.
* @return
*   array A form array.
*/
function phptemplate_settings($saved_settings) {
  /*
   * The default values for the theme variables. Make sure $defaults exactly
   * matches the $defaults in the template.php file.
   */
  $defaults = array(
    'newswire_color_global'    => 'newswire_tan',
    'newswire_color_highlight' => 'newswire_red',
  );

  // Merge the saved variables and their default values
  $settings = array_merge($defaults, $saved_settings);

  // Create the form widgets using Forms API
  $form['newswire_color_global'] = array(
    '#type' => 'select',
    '#title' => t('Page Colors'),
    '#default_value' => $settings['newswire_color_global'],
    '#description' => t('Select the default color for blocks, borders and other page colors and backgrounds.'),
    '#options' => array(
      'newswire_p-gray' => t('Gray'),
      'newswire_tan'  => t('Tan'),
    ),
  );
  $form['newswire_color_highlight'] = array(
    '#type' => 'select',
    '#title' => t('Highlight Colors'),
    '#default_value' => $settings['newswire_color_highlight'],
    '#description' => t('Select the default color for the header nav, search box and drop down menus.'),
    '#options' => array(
      'newswire_red'    => t('Ruby Red'),
      'newswire_blue'   => t('Saphire Blue'),
      'newswire_green'  => t('Emerald Green'),
      'newswire_orange' => t('Sunset Orange'),
      'newswire_h-gray' => t('Cloudy Gray'),
      'newswire_brown'  => t('Chocolate Brown'),
    ),
  );

  // Return the additional form widgets
  return $form;
}
