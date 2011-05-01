<?php
// $Id: color.inc,v 1.1.4.2 2008/08/03 20:07:47 couzinhub Exp $

$info = array(

  // Pre-defined color schemes
  'schemes' => array(
  	'#e0dbc2,#D63E03,#e0dbc2,#e0dbc2,#545454' => t('Athens (Default)'),
		'#bce0f6,#0074cd,#C7C2A9,#C7C2A9,#4e5c64' => t('Monday'),
		'#f3f3f3,#9f8741,#C7C2A9,#C7C2A9,#6e6e6e' => t('White and Gold'),
		'#65bcf1,#014e88,#C7C2A9,#C7C2A9,#6b6b6b' => t('Drupal Blue'),
		'#ccccff,#32609f,#C7C2A9,#C7C2A9,#8f8f8f' => t('Periwinkle'),
		'#c3f8ab,#0074cd,#C7C2A9,#C7C2A9,#71605b' => t('Vancouver'),
		'#baab7d,#840000,#C7C2A9,#C7C2A9,#6e6e6e' => t('Woody'),
		'#f5ca00,#c0480c,#C7C2A9,#C7C2A9,#3b3b3b' => t('Golden Boy'),
		
		
		'#7db798,#877123,#C7C2A9,#C7C2A9,#193930' => t('RCS - Aufumy'),
		'#06757a,#f27a0d,#C7C2A9,#C7C2A9,#064499' => t('RCS - Katbailey'),
		'#ff44f0,#13ef41,#C7C2A9,#C7C2A9,#8a00ff' => t('RCS - Steve K'),
  ),

  // Coordinates of all the theme slices (x, y, width, height)
  // with their filename as used in the stylesheet.
  'slices' => array(
    'images/bg.gif'												=> array(0, 0, 630, 80),
		'images/side-li-active.gif'						=> array(278, 219, 13, 7),
		'images/side-li.gif'									=> array(278, 235, 13, 7),
		'images/primary.gif'									=> array(276, 273, 15, 6),
		'images/primary-active.gif'						=> array(276, 285, 15, 6),
		'images/header-side.gif'							=> array(0, 0, 15, 15),
    'images/screenshot.png'								=> array(0, 0, 400, 240),
    'images/footer-corner.gif'						=> array(236, 522, 29, 29),
    'images/footer-corner2.gif'						=> array(187, 522, 29, 29),
    'images/block.gif'										=> array(0, 434, 260, 18),
    'images/bullet.gif'										=> array(242, 386, 4, 4),
  ),

	'copy' => array(
	  'images/comment.gif',
	  'images/delete.gif',
	  'images/edit.gif',
	  'images/reply.gif',
	  'images/shadow-bottom.gif',
  ),

  // Color areas to fill (x, y, width, height)
  'fill' => array(
    'base' => array(0, 0, 760, 568),
    'link' => array(107, 533, 41, 23),
  ),

	// CSS files (excluding @import) to rewrite with new color scheme.
  'css' => array(
    'style.css',
  ),
  
  // Reference color used for blending. Matches the base.png's colors.
  'blend_target' => '#ffffff',

  // Preview files
  'preview_image' => 'color/preview.png',
  'preview_css' => 'color/preview.css',

  // Base file for image generation
  'base_image' => 'color/base.png',
);
