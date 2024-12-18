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
// $Id: checkout.post.php 10229 2010-07-27 14:21:39Z 2tl $
//

if ( !defined('AREA') ) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	
	if ($mode == 'point_payment') {

		$points_to_use = intval($_REQUEST['points_to_use']);
		if (!empty($points_to_use) && abs($points_to_use) == $points_to_use) {
			$_SESSION['cart']['points_info']['in_use']['points'] = $points_to_use;
		}
		
		$redirect_mode = isset($_REQUEST['redirect_mode']) ? $_REQUEST['redirect_mode'] : 'checkout';

		return array(CONTROLLER_STATUS_REDIRECT, "checkout.$redirect_mode.show_payment_options");
	}
	
	return;
}

if ($mode == 'delete_points_in_use') {
	unset($_SESSION['cart']['points_info']['in_use']);
	
	$redirect_mode = isset($_REQUEST['redirect_mode']) ? $_REQUEST['redirect_mode'] : 'checkout';

	return array(CONTROLLER_STATUS_REDIRECT, "checkout.$redirect_mode.show_payment_options");
}

?>