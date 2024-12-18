<?php
/***************************************************************************
*                                                                          *
*   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/


if ( !defined('AREA') ) { die('Access denied'); }

function fn_settings_variants_addons_price_list_price_list_fields()
{
	$schema = fn_get_schema('price_list', 'schema', 'php', false);
	$result = array();
	
	if (!empty($schema['fields'])) {
		foreach ($schema['fields'] as $field_id => $field) {
			$result[$field_id] = $field['title'];
		}
	}
	
	return $result;
}

function fn_settings_variants_addons_price_list_price_list_sorting()
{
	$schema = fn_get_schema('price_list', 'schema', 'php', false);
	
	if (!empty($schema['fields'])) {
		foreach ($schema['fields'] as $field => $field_info) {
			if (!empty($field_info['sort_by'])) {
				$fields[$field] = $field_info['title'];
			}
		}
	}
	
	return $fields;
}

function fn_price_list_xls_url_info()
{
	$link = fn_url('price_list.view?display=', 'C', 'http');
	$return_url = fn_url('addons.manage', 'A', defined('HTTPS')? 'https' : 'http');
	$text = fn_get_lang_var('xml_info') . '<br />';
	
	$modes = fn_price_list_get_pdf_layouts();
	
	if (!empty($modes['xls'])) {
		foreach ($modes['xls'] as $mode) {
			$mode = basename($mode, '.php');
			$text .= '<a href="' . $link . $mode . '&sl=' . CART_LANGUAGE . '&return_url=' . urlencode($return_url) . '">' . $link . $mode . '</a><br />';
		}
	}
	
	$text .= fn_get_lang_var('xls_images_note') . '<br />';
	$text .= '<br />';
	
	return $text;
}

function fn_price_list_pdf_url_info()
{
	$link = fn_url('price_list.view?display=', 'C', 'http');
	$return_url = fn_url('addons.manage', 'A', defined('HTTPS')? 'https' : 'http');
	$text = fn_get_lang_var('pdf_info') . '<br />';
	$modes = fn_price_list_get_pdf_layouts();
	
	if (!empty($modes['pdf'])) {
		foreach ($modes['pdf'] as $mode) {
			$mode = basename($mode, '.php');
			$text .= '<a href="' . $link . $mode . '&sl=' . CART_LANGUAGE . '&return_url=' . urlencode($return_url) . '">' . $link . $mode . '</a><br />';
		}
	}
	
	$text .= '<br />';
	
	return $text;
}

function fn_price_list_clear_url_info()
{
	return str_replace('[admin_index]', fn_get_index_script(), fn_get_lang_var('clear_cache_info'));
}

function fn_price_list_build_combination($options, $variants, $string, $cycle)
{
	// Look through all variants
	foreach ($variants[$cycle] as $variant_id) {
		if (count($options) - 1 > $cycle) {
			$string[$cycle][$options[$cycle]] = $variant_id;
			$cycle ++;
			$combination[] = fn_price_list_build_combination($options, $variants, $string, $cycle);
			$cycle --;
			unset($string[$cycle]);
		} else {
			$_combination = array();
			if (!empty($string)) {
				foreach ($string as $val) {
					foreach ($val as $opt => $var) {
						$_combination[$opt] = $var;
					}
				}
			}
			$_combination[$options[$cycle]] = $variant_id;
			$combination[] = $_combination;
		}
	}
	
	if (!empty($combination[0][0])) {
		if (is_array($combination[0][0])) {
			$_combination = array();
			
			foreach ($combination as $c) {
				$_combination = array_merge($_combination, $c);
			}
			
			$combination = $_combination;
			unset($_combination);
		}
	}
	
	if (!empty($combination)) {
		return $combination;
		
	} else {
		return false;
	}
};

function fn_price_list_get_combination($product)
{
	$poptions = $product['product_options'];
	
	if (!empty($poptions)) {
		if ($product['tracking'] = 'O') {
			$product['option_inventory'] = db_get_array("SELECT combination_hash as options, amount, product_code FROM ?:product_options_inventory WHERE product_id= ?i", $product['product_id']);
		}
		
		$product['product_code'] = db_get_field("SELECT product_code FROM ?:products WHERE product_id= ?i", $product['product_id']);
	
		//Get variants combinations
		$_options = array_keys($poptions);
		
		foreach ($_options as $key => $option_id) {
			$variants[$key] = array_keys($poptions[$option_id]['variants']);
		}
		
		$combinations = fn_price_list_build_combination($_options, $variants, '', 0);
		if (!empty($combinations)) {
			foreach ($combinations as $c_id => $c_value) {
				$m_price = 0;
				$m_weight = 0;
				
				foreach ($c_value as $option_id => $variant_id) {
					if ($poptions[$option_id]['variants'][$variant_id]['modifier_type'] == 'A') {
						$m_price += $poptions[$option_id]['variants'][$variant_id]['modifier'];
						$m_weight += $poptions[$option_id]['variants'][$variant_id]['weight_modifier'];
					} else {
						$m_price += $product['base_price'] * $poptions[$option_id]['variants'][$variant_id]['modifier'] / 100;
						$m_weight += $product['weight'] * $poptions[$option_id]['variants'][$variant_id]['weight_modifier'] / 100;
					}
				}
				
				$product['combination_prices'][$c_id] = $product['base_price'] + $m_price;
				$product['combination_weight'][$c_id] = $product['weight'] + $m_weight;
				
				$amount = $product_code = '';
				
				if (!empty($product['option_inventory'])) {
					$hash = fn_generate_cart_id($product['product_id'], array('product_options' => $c_value));
					foreach ($product['option_inventory'] as $id => $inventory) {
						if ($inventory['options'] == $hash) {
							$amount = $inventory['amount'];
							$product_code = $inventory['product_code'];
							unset($product['option_inventory'][$id]);
							break;
						}
					}
				}
				
				$product['combination_amount'][$c_id] = empty($amount) ? $product['amount'] : $amount;
				$product['combination_code'][$c_id] = empty($product_code) ? $product['product_code'] : $product_code;
			}
		}
		
		$product['combinations'] = $combinations;
	}
	
	return $product;
}

function fn_price_list_get_pdf_layouts()
{
	$templates = array();
	
	// New version. Include PHP libs.
	$templates['pdf'] = fn_get_dir_contents('addons/price_list/templates/pdf', false, true, 'php');
	$templates['xls'] = fn_get_dir_contents('addons/price_list/templates/xls', false, true, 'php');
	
	return $templates;
}

function fn_price_list_build_category_name($id_path)
{
	$result = array();
	$cat_ids = explode('/', $id_path);
	
	if (!empty($cat_ids)) {
		$cats = fn_get_category_name($cat_ids);
		
		foreach ($cats as $cat_id => $cat_name) {
			$result[] = $cat_name;
		}
	}
	
	return implode(' - ', $result);
};

function fn_price_list_timer($shift = false)
{
	static $first = 0;
	static $last;
	
	list($usec, $sec) = explode(" ", microtime());
	$now = (float)$usec + (float)$sec;
	
	if (!$first) {
		$first = $now;
	}
	
	$res = $shift ? $now - $last : $now - $first;
	$last = $now;
	return $res;
}

?>