function validateFrm(){
		var name=$("#name").val();
		var phone=$("#mobilePhone").val();
		var bookingDate=$("#bookingDate").val();
		if(name==''||name.length<=0){
			$("#name").focus();
			return false;
		}
		if(phone==''||phone.length<=0){
			$("#mobilePhone").focus();
			return false;
		}else{
			if(checkMobilePhone(phone)==true||checkPhone(phone)==true){
			}else{
				$("#mobilePhone").focus();
				return false;
			}
		}
		if(bookingDate==''||bookingDate.length<0){
			$("#bookingDate").focus();
			return false;
		}
		return true;	
	}
	/**
	 * 功能：判断手机号码
	 */
	function checkMobilePhone(value) {
		var valid = false;
		valid = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/.test(value);
		return valid;
	}
	/**
	 * 功能：判断电话号码是否合法，电话号码的格式为：电话号码；或者 区号-电话号码
	 */
	function checkPhone(value) {
		var valid = false;
		valid = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/.test(value);
		return valid;
	}
	
	function ajaxCarModel(sel){
		var options=$("#"+sel+" option:selected");
		var value=options[0].value;
		$("#carModel").remove();
		if(value==''||value<=0){
			return;
		}
		$.post("${ctx}/carModel/ajaxCarModel?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#areaLabel").append(data);
			}
		});
	}
	function ajaxSubmit(url){
		var state=validateFrm();
		if(state){
			var params = $("#frmId").serialize();
			$.post(url,params,function callBack(data) {
				if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
					// 保存数据成功时页面需跳转到列表页面
					$("#message").addClass("alert alert-success");
					$("#message").text(data[0].message);
					$("#message").css("display","");
					$("#message").show();
					$("#subButton").attr("onclick","")
					$("#subButton").find("a").css("color","#E3E0D5");
					
				}
				if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
					// 保存失败时页面停留在数据编辑页面
					$("#message").addClass("alert alert-error");
					$("#message").text(data[0].message);
					$("#message").css("display","");
					$("#message").show();
				}
				return;
			});
		}
	}
	
	
	
	/*
	* jQuery Watermark plugin
	* @requires jQuery v1.3 or later
	*
	* Examples at: http://mario.ec/static/jq-watermark/
	* Copyright (c) 2010 Mario Estrada
	* Licensed under the MIT license:
	* http://www.opensource.org/licenses/mit-license.php
	*
	*/

	;(function ($) {
	  var old_ie = /MSIE [1-7]\./.test(navigator.userAgent);
	  var hard_left = 4;
	  $.watermarker = function () { };
	  $.extend($.watermarker, {
	    defaults: {
	      color: '#999',
	      left: 0,
	      top: 0,
	      fallback: false,
	      animDuration: 300,
	      minOpacity: 0.6
	    },
	    setDefaults: function (settings) {
	      $.extend($.watermarker.defaults, settings);
	    },
	    checkVal: function (val, label) {
	      if (val.length === 0) {
	        $(label).show();
	      } else {
	        $(label).hide();
	      }

	      return val.length > 0;
	    },
	    html5_support: function () {
	      var i = document.createElement('input');
	      return 'placeholder' in i;
	    }
	  });

	  $.fn.watermark = function (text, options) {
	    var elems;
	    options = $.extend({}, $.watermarker.defaults, options);
	    elems = this.filter('textarea, input:not(:checkbox,:radio,:file,:submit,:reset)');

	    if (options.fallback && $.watermarker.html5_support()) {
	      return this;
	    }

	    elems.each(function () {
	      var $elem, attr_name, label_text, watermark_container, watermark_label, control_id;
	      var e_margin_left, e_top = 0, e_height;

	      $elem = $(this);
	      control_id = $elem.attr('id');

	      if ($elem.attr('data-jq-watermark') === 'processed') {
	        return;
	      }

	      attr_name = $elem.attr('placeholder') !== undefined && $elem.attr('placeholder') !== '' ? 'placeholder' : 'title';
	      label_text = text === undefined || text === '' ? $(this).attr(attr_name) : text;
	      watermark_container = $('<span class="watermark_container"></span>');
	      watermark_label = $('<label class="watermark" for="' + control_id + '">' + label_text + '</label>');

	      // If used, remove the placeholder attribute to prevent conflicts
	      if (attr_name === 'placeholder') {
	        $elem.removeAttr('placeholder');
	      }

	      watermark_container.css({
	        display: 'inline-block',
	        position: 'relative'
	      });

	      if ($elem.attr('data-percent-width') === 'true') {
	        watermark_container.css('width', '100%');
	      }

	      if ($elem.attr('data-percent-height') === 'true') {
	        watermark_container.css('height', '100%');
	      }

	      if (old_ie) {
	        watermark_container.css({
	          zoom: 1,
	          display: 'inline'
	        });
	      }

	      $elem.wrap(watermark_container).attr('data-jq-watermark', 'processed');

	      if (this.nodeName.toLowerCase() === 'textarea') {
	        e_height = parseInt($elem.css('line-height'), 10);
	        e_height = e_height === 'normal' ? parseInt($elem.css('font-size'), 10) : e_height;
	        e_top = ($elem.css('padding-top') !== 'auto' ? parseInt($elem.css('padding-top'), 10) : 0);
	      } else {
	        e_height = $elem.outerHeight();
	        if (e_height <= 0) {
	          e_height = ($elem.css('padding-top') !== 'auto' ? parseInt($elem.css('padding-top'), 10) : 0);
	          e_height += ($elem.css('padding-bottom') !== 'auto' ? parseInt($elem.css('padding-bottom'), 10) : 0);
	          e_height += ($elem.css('height') !== 'auto' ? parseInt($elem.css('height'), 10) : 0);
	        }
	      }

	      e_top += ($elem.css('margin-top') !== 'auto' ? parseInt($elem.css('margin-top'), 10) : 0);

	      e_margin_left = $elem.css('margin-left') !== 'auto' ? parseInt($elem.css('margin-left'), 10) : 0;
	      e_margin_left += $elem.css('padding-left') !== 'auto' ? parseInt($elem.css('padding-left'), 10) : 0;

	      watermark_label.css({
	        position: 'absolute',
	        display: 'block',
	        fontFamily: $elem.css('font-family'),
	        fontSize: 14+'px',
	        left: hard_left + options.left + e_margin_left,
	        top: options.top + e_top,
	        height: e_height,
	        width:180+'px',
	        lineHeight: 20 + 'px',
	        textAlign: 'left',
	        pointerEvents: 'none'
	      });

	      $.watermarker.checkVal($elem.val(), watermark_label);

	      if (!control_id) {
	        watermark_label
	          .data('jq_watermark_element', $elem)
	          .click(function () {
	            $($(this).data('jq_watermark_element')).trigger('click').trigger('focus');
	          });
	      }

	      $elem.before(watermark_label)
	        .bind('focus.jq_watermark', function () {
	          if (!$.watermarker.checkVal($(this).val(), watermark_label)){
	            watermark_label.stop().fadeTo(options.animDuration, options.minOpacity);
	          }
	        })
	        .bind('blur.jq_watermark change.jq_watermark', function () {
	          if (!$.watermarker.checkVal($(this).val(), watermark_label)){
	            watermark_label.stop().fadeTo(options.animDuration, 1);
	          }
	        })
	        .bind('keydown.jq_watermark, paste.jq_watermark', function (e) {
	          $(watermark_label).hide();
	        })
	        .bind('keyup.jq_watermark', function (e) {
	          $.watermarker.checkVal($(this).val(), watermark_label);
	        });
	    });

	    return this;
	  };

	  $(function () {
	    $('.jq_watermark').watermark();
	  });
	})(jQuery);
