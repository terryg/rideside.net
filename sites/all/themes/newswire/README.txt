  
  Found a bug or need support?
  Please visit the project page and post it in the issue queue.
  http://drupal.org/project/newswire
  
  Please contact jeff [att] adaptivethemes [a.dot] com for customizations.

  Installation and basic configuration:

  1. Download Newswire theme from http://drupal.org/project/newswire


  2. Unpack the downloaded file, take the entire newswire folder (which includes
     the README.txt file and all the themes files) and place it in your Drupal 
     installation under one of the following locations:

       sites/all/themes
         making it available to the default Drupal site and to all Drupal sites
         in a multi-site configuration
       sites/default/themes
         making it available to only the default Drupal site
       sites/example.com/themes
         making it available to only the example.com site if there is a
         sites/example.com/settings.php configuration file


  3. Log in as an administrator on your Drupal site and go to:
     Administer > Site building > Themes (admin/build/themes) 
     and make newswire the default theme.


  4. Theme Settings.

     Go to:
     Administer > Site building > Themes > Configure > Newswire (admin/build/themes/settings/newswire) 
     and configure settings for the newswire theme. 
	 
     All features are supported but you can only display a logo OR the site name. 
     If the logo is checked, newswire will display the logo - you must uncheck 
     logo to display the site name in the header.

     SETTING YOUR DEFAULT COLORS
     On the theme settings page, scroll to the bottom and you will see two new drop
     menus - select your desired theme style sheets and save your settings.

     You can mix and match the page the header/nav colors.


  5. Blocks.
  
     Go to: 
     Administer > Site building > Blocks (admin/build/block/list/newswire)
     and configure your block settings.
	 
     Newswire has 4 columns and multiple additional regions.
	 
     A region will only become active if a block is placed within it, this includes the
     3 sidebars - Left, Right_2 (inside right) and Right.
		 
     NOTE: The regions "Right top box" & "Right bottom box" can only be active IF both the
     Right and Right_2 regions are also active.

     SKINR BLOCK BORDER AND BACKGROUND STYLES
     This theme uses the Skinr module to give your blocks fancy border and background styles.
     You need to download and install the module http://drupal.org/project/skinr to use this feature
     of the theme. After you have enabled the module you will have new configuration options on
     each block config page.


  6. Default Avatar.
  
     If you would like to use the anonymous users avatar supplied with the theme,
     go to User management > User setting (admin/user/settings), enable pictures
     for users and paste in the path "sites/all/themes/newswire/images/avatar.png".
     Modify the path if you have installed newswire in a different directory. 
	 
     Newswire is designed to support user pictures/avatars of the default size 
     (85x85px), but can be modified by editing style.css to accommodate user pictures
     of any size.


  7. Suckerfish Drop Menus. 
  
     The first thing you must do is disable Primary links
     in the theme settings. If you don't your menu won't show up.

     Create your menu with the standard Drupal menu system. Make sure all menu 
     entries are set to "expanded". Place the menu block in the Suckerfish region, be 
     sure to set the block title as <none>. The menu will automagically become a drop menu.

     Note that its perfectly fine to use the Primary Menu Block for this as well.





