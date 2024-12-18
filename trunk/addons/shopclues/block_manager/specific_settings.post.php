<?php
/***************************************************************************
*                                                                          *
*    Copyright (c) 2009 Simbirsk Technologies Ltd. All rights reserved.    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/


//
// $Id: specific_settings.post.php 10953 2010-10-19 12:06:06Z klerik $
//

if ( !defined('AREA') ) { die('Access denied'); }

$schema['list_object']['blocks/information_html_block.tpl'] = array (
			'settings' => array (
				'items_function' => 'fn_get_html_content',
				'hide_label' => true,
				'section' => 'special',
				'force_open' => true,
			),
			'block_text' => array (
				'type' => 'text',
				'multilingual' => true,
			)
);

/*
$schema['fillings']['tag_cloud'] = array (
	'limit' => array (
		'type' => 'input',
		'default_value' => 50
	)
);*/

?>
