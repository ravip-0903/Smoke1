{* $Id: recover_password.tpl 11094 2010-11-01 12:29:45Z 2tl $ *}

{include file="letter_header.tpl"}

{$lang.text_confirm_passwd_recovery}:<br /><br />

<a href="{"auth.recover_password?ekey=`$ekey`"|fn_url:$zone:'http':'&'}">{"auth.recover_password?ekey=`$ekey`"|fn_url:$zone:'http':'&'}</a>

{include file="letter_footer.tpl"}