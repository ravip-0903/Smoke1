<?php
/***************************************************************************
*                                                                          *
*    Copyright (c) 2004 Simbirsk Technologies Ltd. All rights reserved.    *
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
// $Id: init.php 11501 2010-12-29 09:23:57Z klerik $
//

if ( !defined('AREA') ) { die('Access denied'); }

fn_register_hooks(
	'change_order_status',
	'delete_product',
	'delete_category',
	'get_products_params',
	'get_products',
	'products_sorting',
	'update_product',
	'get_product_data'
);

?>