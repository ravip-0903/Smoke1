{* $Id: index.tpl 12859 2011-07-04 15:32:26Z subkey $ *}

{capture name="mainbox"}
{assign var="show_latest_orders" value="orders"|fn_check_permissions:'manage':'admin'}
{assign var="show_orders" value="sales_reports"|fn_check_permissions:'reports':'admin'}
{assign var="show_inventory" value="products"|fn_check_permissions:'manage':'admin'}
{assign var="show_users" value="profiles"|fn_check_permissions:'manage':'admin'}
{hook name="index:index"}

{assign var="company_status" value=$smarty.session.auth.company_id|fn_get_company_status}
{assign var="password_status" value=$smarty.session.auth.company_id|fn_password_change_status}
{assign var="product_count" value=$smarty.session.auth.company_id|fn_product_count}
{assign var="store_status" value=$smarty.session.auth.company_id|fn_store_status}

<table cellpadding="0" cellspacing="0" border="0" width="100%" class="table-fixed">
<tr valign="top">
<td width="80%">
    
{if $smarty.session.auth.company_id!=0}
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
   
      <td width="20%" valign="top">
        <div class="statistics-box overall" style="margin-right:10px; height:145px; position:relative;">
            <h2 style="margin: 0; font-size: 18px; padding: 10px 14px 0px; color: #595959; border: 0px solid #E0E0E0; border-bottom-width: 0;">{$lang.account_setup_with_link_to_accountpage}</h2>
            <p style="padding: 10px 14px; color: #555; font-size: 11px;  text-align:left;; margin:0"><a href="vendor.php?dispatch=profiles.update&user_id={$smarty.session.auth.user_id}">{$lang.change_password}</a>{if $password_status}  <img src="skins/basic/admin/images/icons/notification_icon_n.png" height="10" width="10" /> {/if}<br /><a href="vendor.php?dispatch=companies.manage">{$lang.goto_account_setup}</a></p>
            <img src="{$config.ext_images_host}/images/banners/arrow.gif" style="position:absolute; bottom:10px; right:-15px; z-index:2" />
        </div></td>
        
    <td width="20%" valign="top"><div class="statistics-box overall" style="margin-right:10px; height:145px; position:relative;">
            <h2 style="margin: 0; font-size: 18px; padding: 10px 14px 0px; color: #595959; border: 0px solid #E0E0E0; border-bottom-width: 0;">{$lang.store_setup}</h2>
            <!--<p style="padding: 10px 14px; color: #555; font-size: 11px;  text-align:left; margin:0">08 Aug 2012, 07:28 PM</p>-->
                            <p class="dashboard_text_style"><a href="vendor.php?dispatch=storesetup.first_step&company_id={$smarty.session.auth.company_id}">{$lang.store_first_step}{if $store_status.firststepFinished} <img src="skins/basic/admin/images/icons/notification_icon_n.png" height="10" width="10" /> {/if}</a><br/>
                            <a href="vendor.php?dispatch=storesetup.second_step&company_id={$smarty.session.auth.company_id}">{$lang.store_second_step}{if $store_status.secondstepFinished} <img src="skins/basic/admin/images/icons/notification_icon_n.png" height="10" width="10" /> {/if}</a><br/>
                            <a href="vendor.php?dispatch=storesetup.third_step&company_id={$smarty.session.auth.company_id}">{$lang.store_third_step}{if $store_status.thirdstepFinished} <img src="skins/basic/admin/images/icons/notification_icon_n.png" height="10" width="10" /> {/if}</a><br/>
                            <a href="vendor.php?dispatch=storesetup.fourth_step&company_id={$smarty.session.auth.company_id}">{$lang.store_fourth_step}{if $store_status.fourthstepFinished} <img src="skins/basic/admin/images/icons/notification_icon_n.png" height="10" width="10" /> {/if}</a></p>
            <img src="{$config.ext_images_host}/images/banners/arrow.gif" style="position:absolute; bottom:10px; right:-15px; z-index:2" />
        </div></td>
        
    <td width="20%" valign="top">
        <div class="statistics-box overall" style="margin-right:10px; height:145px; position:relative;">
            <h2 style="margin: 0; font-size: 18px; padding: 10px 14px 0px; color: #595959; border: 0px solid #E0E0E0; border-bottom-width: 0;">{$lang.product_upload}</h2>
            <p style="padding: 10px 14px; color: #555; font-size: 11px;  text-align:left; margin:0"><a href="vendor.php?dispatch=products.manage">{$lang.upload_link}</a><br />
                <span style="font-size: 10px; color:#999; padding: 0 0 0 0px;">{$product_count} Product Uploaded {if $product_count > $config.product_upload_count_check} <img src="skins/basic/admin/images/icons/notification_icon_n.png" height="10" width="10" /> {/if}</span><br />
                <br />{$lang.how_to_guides}<br />{$lang.links}<br/> 
                
                {if $store_status.firststepFinished && $store_status.secondstepFinished && $store_status.thirdstepFinished && $store_status.fourthstepFinished && $password_status && ($product_count >= $config.product_upload_count_check) }
                <a href="vendor.php?dispatch=storesetup.request_form" >
                <span class="submit-button cm-button-main" >
                <input type="button" value="RequestApproval">
                </span> 
                </a>
                 {else}
                <a href="#">
                <span class="submit-button cm-button-main" >
                <input type="button" value="RequestApproval" style="background:#E4E4E4 !important; color:#bbb; -moz-text-shadow:none; text-shadow:none; border:0;">
                </span> 
                </a> 
                {/if}
                </p>
            <img src="{$config.ext_images_host}/images/banners/arrow.gif" style="position:absolute; bottom:10px; right:-15px; z-index:2" />
        </div></td>
        
    <td width="18%" valign="top">
        <div class="statistics-box overall" style="margin-right:10px; height:145px; position:relative;">
            <h2 style="margin: 0; font-size: 18px; padding: 10px 14px 0px; color: #595959; border: 0px solid #E0E0E0; border-bottom-width: 0;">{$lang.shopclues_merchant_admin}</h2>
            <p style="padding: 10px 14px; color: #555; font-size: 11px; text-align:left; margin:0">{$lang.finalize_fees}<br />{$lang.sign_mou}<br />{$lang.assign_ful_type}<br />{$lang.store_status}{if $company_status == 'P'}-Pending{elseif $company_status == 'R'}-Request Approval {elseif $company_status == 'N'}-New{elseif $company_status == 'S'}-Suspended{elseif $company_status == 'D'}-Deactive{/if}
             <br/>
          <!--  {if $company_status == 'P'} 
                   <a href="vendor.php?dispatch=storesetup.request_form">{$lang.request_for_approval}</a>
          {/if}--> </p>
        </div></td>
  </tr>
</table> 
          
{$lang.request_button_instructions}
{/if}

<div class="statistics-box overall">
	<div class="statistics-body">
                <a href="{"orders.manage?time_from=`$date.today`&time_to=`$date.TIME`&period=C"|fn_url}" class="section"><span class="price">{include file="common_templates/price.tpl" value=$orders_stats.daily_orders.totals.total_paid} </span><u>{$lang.today}</u> <span class="block">{$lang.prev} {include file="common_templates/price.tpl" value=$orders_stats.daily_orders.prev_totals.total_paid} <span class="percent-{if $orders_stats.daily_orders.totals.profit >= 0}up{else}down{/if}">{if $orders_stats.daily_orders.totals.profit}({if $orders_stats.daily_orders.totals.profit >= 0}+{/if}{$orders_stats.daily_orders.totals.profit}%){/if}</span></span></a>
		
		<a href="{"orders.manage?time_from=`$date.week`&time_to=`$date.TIME`&period=C"|fn_url}" class="section"><span class="price">{include file="common_templates/price.tpl" value=$orders_stats.weekly_orders.totals.total_paid} </span><u>{$lang.week}</u> <span class="block">{$lang.prev} {include file="common_templates/price.tpl" value=$orders_stats.weekly_orders.prev_totals.total_paid} <span class="percent-{if $orders_stats.weekly_orders.totals.profit >= 0}up{else}down{/if}">{if $orders_stats.weekly_orders.totals.profit}({if $orders_stats.weekly_orders.totals.profit >= 0}+{/if}{$orders_stats.weekly_orders.totals.profit}%){/if}</span></span></a>
		
		<a href="{"orders.manage?time_from=`$date.month`&time_to=`$date.TIME`&period=C"|fn_url}" class="section last"><span class="price">{include file="common_templates/price.tpl" value=$orders_stats.monthly_orders.totals.total_paid} </span><u>{$lang.month}</u> <span class="block">{$lang.prev} {include file="common_templates/price.tpl" value=$orders_stats.monthly_orders.prev_totals.total_paid} <span class="percent-{if $orders_stats.monthly_orders.totals.profit >= 0}up{else}down{/if}">{if $orders_stats.monthly_orders.totals.profit}({if $orders_stats.monthly_orders.totals.profit >= 0}+{/if}{$orders_stats.monthly_orders.totals.profit}%){/if}</span></span></a>     
         </div>
</div>
{if $show_latest_orders}
<div class="statistics-box orders">
	{include file="common_templates/subheader_statistic.tpl" title=$lang.latest_orders}
	{assign var="order_status_descr" value=$smarty.const.STATUSES_ORDER|fn_get_statuses:true:true:true}
	<div class="statistics-body">
		{if $latest_orders}
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			{foreach from=$latest_orders item="order"}
			<tr valign="top">
				<td width="17%">
					{assign var="status_descr" value=$order.status}
					<span class="order-status order-{$order.status|lower}"><em>{$order_status_descr.$status_descr}</em></span>
					<p class="order-date">{$order.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</p>
				</td>
				<td width="83%" class="order-description">
					<span class="total">{include file="common_templates/price.tpl" value=$order.total}</span> <a href="{"orders.details?order_id=`$order.order_id`"|fn_url}">{$lang.order}&nbsp;#{$order.order_id}</a> {$lang.by} {if $order.user_id}<a href="{"profiles.update?user_id=`$order.user_id`"|fn_url}">{/if}{$order.firstname} {$order.lastname}{if $order.user_id}</a>{/if}
					<div class="product-name">
						{capture name="order_products"}
							{strip}
							{foreach name="order_items" from=$order.items item="product"}
								{$product.product} x {$product.amount}
								{if !$smarty.foreach.order_items.last}, {/if}
							{/foreach}
							{/strip}
						{/capture}
						{if $smarty.capture.order_products|fn_strlen > 70}
							{$smarty.capture.order_products|fn_substr:0:70}...
						{else}
							{$smarty.capture.order_products}
						{/if}
					</div>
				</td>
			</tr>
			{/foreach}
		</table>
		{else}
			<p class="no-items">{$lang.no_items}</p>
		{/if}
	</div>
</div>
{/if}

{if $show_orders && false} {* Hide section for a while *}
<div class="statistic">
	<table cellpadding="0" cellspacing="0" border="0" width="100%" class="table">
	<tr>
		<th>{$lang.status}</th>
		<th class="center">{$lang.this_day}</th>
		<th class="center">{$lang.this_week}</th>
		<th class="center">{$lang.this_month}</th>
		<th class="center">{$lang.this_year}</th>
	</tr>
	{foreach from=$order_statuses item="status" key="_status"}
	<tr {cycle values="class=\"table-row\", "}>
		<td>{include file="common_templates/status.tpl" status=$_status display="view"}</td>
		<td class="center">{if $orders_stats.daily_orders.$_status.amount}<a href="{"orders.manage?status%5B%5D=`$_status`&amp;period=D"|fn_url}">{$orders_stats.daily_orders.$_status.amount}</a>{else}0{/if}</td>
		<td class="center">{if $orders_stats.weekly_orders.$_status.amount}<a href="{"orders.manage?status%5B%5D=`$_status`&amp;period=W"|fn_url}">{$orders_stats.weekly_orders.$_status.amount}</a>{else}0{/if}</td>
		<td class="center">{if $orders_stats.monthly_orders.$_status.amount}<a href="{"orders.manage?status%5B%5D=`$_status`&amp;period=M"|fn_url}">{$orders_stats.monthly_orders.$_status.amount}</a>{else}0{/if}</td>
		<td class="center">{if $orders_stats.year_orders.$_status.amount}<a href="{"orders.manage?status%5B%5D=`$_status`&amp;period=Y"|fn_url}">{$orders_stats.year_orders.$_status.amount}</a>{else}0{/if}</td>
	</tr>
	{/foreach}
	<tr {cycle values="class=\"table-row\", "}>
		<td><span>{$lang.total_orders}</span></td>
		<td class="center">{if $orders_stats.daily_orders.totals.amount}<a href="{"orders.manage?period=D"|fn_url}">{$orders_stats.daily_orders.totals.amount}</a>{else}0{/if}</td>
		<td class="center">{if $orders_stats.weekly_orders.totals.amount}<a href="{"orders.manage?period=W"|fn_url}">{$orders_stats.weekly_orders.totals.amount}</a>{else}0{/if}</td>
		<td class="center">{if $orders_stats.monthly_orders.totals.amount}<a href="{"orders.manage?period=M"|fn_url}">{$orders_stats.monthly_orders.totals.amount}</a>{else}0{/if}</td>
		<td class="center">{if $orders_stats.year_orders.totals.amount}<a href="{"orders.manage?period=Y"|fn_url}">{$orders_stats.year_orders.totals.amount}</a>{else}0{/if}</td>
	</tr>
	<tr class="strong">
		<td>{$lang.gross_total}</td>
		<td class="center">{include file="common_templates/price.tpl" value=$orders_stats.daily_orders.totals.total|default:"0"}</td>
		<td class="center">{include file="common_templates/price.tpl" value=$orders_stats.weekly_orders.totals.total|default:"0"}</td>
		<td class="center">{include file="common_templates/price.tpl" value=$orders_stats.monthly_orders.totals.total|default:"0"}</td>
		<td class="center">{include file="common_templates/price.tpl" value=$orders_stats.year_orders.totals.total|default:"0"}</td>
	</tr>
	<tr class="strong">
		<td>{$lang.totally_paid}</td>
		<td class="center valued-text">{include file="common_templates/price.tpl" value=$orders_stats.daily_orders.totals.total_paid|default:"0"}</td>
		<td class="center valued-text">{include file="common_templates/price.tpl" value=$orders_stats.weekly_orders.totals.total_paid|default:"0"}</td>
		<td class="center valued-text">{include file="common_templates/price.tpl" value=$orders_stats.monthly_orders.totals.total_paid|default:"0"}</td>
		<td class="center valued-text">{include file="common_templates/price.tpl" value=$orders_stats.year_orders.totals.total_paid|default:"0"}</td>
	</tr>

	</table>
</div>
{/if}



</td>

<td width="30px">&nbsp;</td>

<td width="360px">
<!--Modified by chandan to implement vendor links-->
{hook name="index:extra"}
{/hook}
<!--Modified by chandan to implement vendor links-->

{if $show_inventory}
<div class="statistics-box inventory">
	
	<div class="statistics-body">
		{if !"COMPANY_ID"|defined}
                <p class="strong">{$lang.category_inventory}</p>
		<div class="clear">
			<ul>
				<li>{$lang.total}:&nbsp;{if $category_stats.total}{$category_stats.total}{else}0{/if}</li>
				<li>{$lang.active}:&nbsp;{if $category_stats.status.A}{$category_stats.status.A}{else}0{/if}</li>
			</ul>
			<ul>
				<li>{$lang.hidden}:&nbsp;{if $category_stats.status.H}{$category_stats.status.H}{else}0{/if}</li>
				<li>{$lang.disabled}:&nbsp;{if $category_stats.status.D}{$category_stats.status.D}{else}0{/if}</li>
			</ul>
		</div>
		{/if}
		<p class="strong product-inventory">{$lang.product_inventory}</p>
		<div class="clear">
			<ul>
				<li>{$lang.total}:&nbsp;{if $product_stats.total}<a href="{"products.manage"|fn_url}">{$product_stats.total}</a>{else}0{/if}</li>
				{hook name="index:inventory"}
				{/hook}
				<li>{$lang.in_stock}:&nbsp;{if $product_stats.in_stock}<a href="{"products.manage?amount_from=1&amp;amount_to=&amp;tracking[]=B&amp;tracking[]=O"|fn_url}">{$product_stats.in_stock}</a>{else}0{/if}</li>
				<li>{$lang.active}:&nbsp;{if $product_stats.status.A}<a href="{"products.manage?status=A"|fn_url}">{$product_stats.status.A}</a>{else}0{/if}</li>
				<li>{$lang.disabled}:&nbsp;{if $product_stats.status.D}<a href="{"products.manage?status=D"|fn_url}">{$product_stats.status.D}</a>{else}0{/if}</li>
			</ul>
			<ul>
				<li>{$lang.downloadable}:&nbsp;{if $product_stats.downloadable}<a href="{"products.manage?downloadable=Y"|fn_url}">{$product_stats.downloadable}</a>{else}0{/if}</li>
				<li>{$lang.text_out_of_stock}:&nbsp;{if $product_stats.out_of_stock}<a href="{"products.manage?amount_from=&amp;amount_to=0&amp;tracking[]=B&amp;tracking[]=O"|fn_url}">{$product_stats.out_of_stock}</a>{else}0{/if}</li>
				<li>{$lang.hidden}:&nbsp;{if $product_stats.status.H}<a href="{"products.manage?status=H"|fn_url}">{$product_stats.status.H}</a>{else}0{/if}</li>

				<li>{$lang.free_shipping}:&nbsp;{if $product_stats.free_shipping}<a href="{"products.manage?free_shipping=Y"|fn_url}">{$product_stats.free_shipping}</a>{else}0{/if}</li>
			</ul>
		</div>
	</div>
</div>
{/if}

{if !"COMPANY_ID"|defined && !"RESTRICTED_ADMIN"|defined}
{if $show_users}
<div class="statistics-box users">
	{include file="common_templates/subheader_statistic.tpl" title=$lang.users}
	
	<div class="statistics-body clear">
	<ul>
		<li class="customer-users">
			<span>{$lang.customers}:</span>
			<em>{if $users_stats.total.C}<a href="{"profiles.manage?user_type=C"|fn_url}">{$users_stats.total.C}</a>{else}0{/if}</em>
		</li>

		{if $usergroups_type.C}
		<li>
			<span>{$lang.not_a_member}:</span>
			<em>{if $users_stats.not_members.C}<a href="{"profiles.manage?usergroup_id=0&amp;user_type=C"|fn_url}">{$users_stats.not_members.C}</a>{else}0{/if}</em>
		</li>
		{/if}
		{foreach from=$usergroups key="mem_id" item="mem_name"}
		{if $mem_name.type == "C"}
			<li>
				<span>{$mem_name.usergroup}:</span>
				<em>{if $users_stats.usergroup.C.$mem_id}<a href="{"profiles.manage?usergroup_id=`$mem_id`"|fn_url}">{$users_stats.usergroup.C.$mem_id}</a>{else}0{/if}</em>
			</li>
		{/if}
		{/foreach}
		<li class="staff-users">
			<span>{$lang.staff}:</span>
			<em>{if $users_stats.total.A}<a href="{"profiles.manage?user_type=A"|fn_url}">{$users_stats.total.A}</a>{else}0{/if}</em>
		</li>

		{if $usergroups_type.A}
		<li>
			<span>{$lang.root_administrators}:</span>
			<em>{if $users_stats.not_members.A}<a href="{"profiles.manage?usergroup_id=0&amp;user_type=A"|fn_url}">{$users_stats.not_members.A}</a>{else}0{/if}</em>
		</li>
		{/if}
		{foreach from=$usergroups key="mem_id" item="mem_name"}
		{if $mem_name.type == "A"}
			<li>
				<span>{$mem_name.usergroup}:</span>
				<em>{if $users_stats.usergroup.A.$mem_id}<a href="{"profiles.manage?usergroup_id=`$mem_id`"|fn_url}">{$users_stats.usergroup.A.$mem_id}</a>{else}0{/if}</em>
			</li>
		{/if}
		{/foreach}
		{hook name="index:users"}
		{/hook}
		<li class="total-users">
			<span>{$lang.total}:</span>
			<em>{if $users_stats.total_all}<a href="{"profiles.manage"|fn_url}">{$users_stats.total_all}</a>{else}0{/if}</em>
		</li>

		<li class="disabled-users">
			<span>{$lang.disabled}:</span>
			<em>{if $users_stats.not_approved}<a href="{"profiles.manage?status=D"|fn_url}">{$users_stats.not_approved}</a>{else}0{/if}</em>
		</li>
	</ul>
	</div>
</div>
{/if}
{assign var="show_shippings" value="shippings"|fn_check_permissions:'manage':'admin'}
{assign var="show_payments" value="payments"|fn_check_permissions:'manage':'admin'}
{assign var="show_settings" value="settings"|fn_check_permissions:'manage':'admin'}
{assign var="show_database" value="database"|fn_check_permissions:'manage':'admin'}
{assign var="show_add_page" value="pages"|fn_check_permissions:'manage':'admin':'POST'}
{assign var="show_blocks" value="block_manager"|fn_check_permissions:'manage':'admin'}
{if $show_inventory || $show_shippings || $show_payments || $show_settings || $show_database || $show_add_page ||  $show_blocks}
<div class="statistics-box shortcuts">
	{include file="common_templates/subheader_statistic.tpl" title=$lang.shortcuts}

	<div class="statistics-body clear">
		<ul class="arrow-list float-left">
			{if $show_inventory}<li><a href="{"products.manage"|fn_url}">{$lang.manage_products}</a></li>{/if}
			{if $show_inventory}<li><a href="{"categories.manage"|fn_url}">{$lang.manage_categories}</a></li>{/if}
			{if $show_shippings}<li><a href="{"shippings.manage"|fn_url}">{$lang.shipping_methods}</a></li>{/if}
			{if $show_payments}<li><a href="{"payments.manage"|fn_url}">{$lang.payment_methods}</a></li>{/if}
		</ul>

		<ul class="arrow-list float-left">
			{if $show_settings}<li><a href="{"settings.manage"|fn_url}">{$lang.general_settings}</a></li>{/if}
			{if $show_database}<li><a href="{"database.manage"|fn_url}">{$lang.db_backup_restore}</a></li>{/if}
			{if $show_add_page}<li><a href="{"pages.add&amp;parent_id=0"|fn_url}">{$lang.add_inf_page}</a></li>{/if}
			{if $show_blocks}<li><a href="{"block_manager.manage"|fn_url}">{$lang.manage_blocks}</a></li>{/if}
		</ul>
	</div>
</div>
{/if}
{/if}

</td>
</tr>
</table>
{/hook}

{capture name="tools"}
	{if $settings.General.feedback_type == 'manual' && !"COMPANY_ID"|defined && !"RESTRICTED_ADMIN"|defined}
		<div class="tools-container">
		{*{include file="common_templates/object_group.tpl" link_text="`$lang.send_feedback`&nbsp;&#155;&#155;" content=$smarty.capture.update_block id="feedback" no_table=true header_text=$lang.feedback_values but_name="dispatch[feedback.send]" href="feedback.prepare" opener_ajax_class="cm-ajax" link_class="cm-ajax-force" picker_meta="cm-clear-content" act='edit'}*}
		</div>
	{/if}
{/capture}
{/capture}
{include file="common_templates/mainbox.tpl" title=$lang.dashboard content=$smarty.capture.mainbox tools=$smarty.capture.tools}