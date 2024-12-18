{** block-description:recommendation_vr_block **}

<div class="bs_cntnr_vr" id="bs_cntnr_reco">
    <div class="bs_cntnr_vr_head">
        <a id="desc">{$lang.recommendations_vertical}</a>
    </div>
    <div class="bs_cntnr_ovr_blk_vr" id="reco">
    </div>
</div>


{literal}
<script>

    $(document).ready(function(){

        var prod_id = {/literal}{$product.product_id}{literal};
        var limit = {/literal}{$config.TM_limit}{literal};
        var url = "http://api.targetingmantra.com/TMWidgets?w=rhf&mid=130915&pid="+prod_id+"&limit="+limit +"&json=true&callback=?";
        jQuery.getJSON(url,function(data){


            if( !data.rhf || !data.rhf.recommendations || !data.rhf.recommendations.recommendedItems || data.rhf.recommendations.recommendedItems.length == 0){
                $("#bs_cntnr_reco").hide();
            }
            else{
                var widgetTitle = data.rhf.recommendations.subWidgetTitle;
                $("#bs_cntnr_reco").show();

                data.rhf.recommendations.recommendedItems.forEach(function(obj, index){
                    var prod_num=index+1;
                    var mrp = (function(){
                        if(parseFloat(obj.itemMRP) > parseFloat(obj.itemPrice)){
                            return parseFloat(obj.itemMRP).formatMoney(0,'.',',');
                        }
                        else{
                            return parseFloat(obj.itemPrice).formatMoney(0,'.',',');
                        }
                    })();
                    var img = document.createElement("img");
                    img.src = obj.itemImage;
                    img.setAttribute("width","48");
                    img = img.outerHTML;
                    var title = function(){if(obj.itemTitle.length >50){return obj.itemTitle.substr(0,46) + "...";}else{return obj.itemTitle;}};
                    var item = "<div class='bs_cntnr_item_vr'><div class='bs_cntnr_img_vr'>"+ img +"</div><div class='prd_info_left_blk'><a onclick=\"_gaq.push(['_trackEvent', 'Product_recommend_vertical', 'Click', 'Product_"+prod_num+"']);\" class='bs_cntnr_prd_name_vr' href='"+ obj.itemURL +"'>" + title() +"</a>"
                            +"<div id='reco_stars_"+index+"'></div><span class='list-price' style='font-size: 12px;'>Price: </span><span class='list-price' style='font-size:11px' id='reco_price_"+index+"'><strike>Rs."+mrp+"</strike></span><div class='bs_cntnr_prc_blk_vr'><div class='bs_main_price_vr'>Rs. " + parseFloat(obj.itemPrice).formatMoney(0,'.',',') +"</div></div></div></div>";
                    $("#reco").append(item);
                    if(parseInt(obj.itemRating) > 0){
                        $("#reco_stars_" + index).append("<span class='stars' id='reco_"+index+"'>"+obj.itemRating+"</span>");
                    }
                    $("#reco_" + index).makeStars();
                    if(parseFloat(obj.itemMRP) == parseFloat(obj.itemPrice)){
                        $("#reco_price_"+index).hide();
                    }
                });
            }

        });
    });
</script>
{/literal}