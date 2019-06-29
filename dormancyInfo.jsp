<jsp:directive.page contentType="text/html;charset=UTF-8" />
<jsp:directive.include file="/WEB-INF/jsp/common/taglibs.jsp"/>
<div id="contents" class="login">
	<div class="body-inner">
		<section>
			<div class="main_title">
				<h2 class="h1">휴면계정 안내</h2>
			</div>
		</section>

		<section>
			<div class="loginCont2 pt50 pb60">
				<div class="logContBox">

					<p class="sub_title mt10">
						<span class="title">현재 회원님 계정은 <em>휴면상태</em> 입니다.</span>
					</p>
					<p class="sub_message mt20">
						<span>
							특정기간 동안 본 홈페이지를 이용하지 않은 경우 <br>
							회원님의 계정을 휴면상태로 변경하고, <br>
							회원님의 개인정보를 안전한 공간에 분리하여 보관합니다. <br>
							[정보통신망 이용촉진 및 정보보호 등에 관한 법률 제29조]
						</span>
					</p>


					<div class="grey-box mt35">
						<p class="tit">휴면 상태 전환일 :
							<span>
								<fmt:parseDate var="updDt" value="${memberDTO.updDt}" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate value="${updDt}" pattern="yyyy년 MM월 dd일" />
							</span>
						</p>
						<p class="msg mt15">휴면 해제를 원하시면 [본인인증]을 해주세요</p>
					</div>

				</div>
			</div>
		</section>

		<section class="last-section">
			<div class="btn_set-center bottom_set">
				<a href="#" class="btn btn_black" id="btnAuth">본인인증</a>
			</div>
		</section>

	</div>
</div>
<form name="plusForm" id="plusForm" method="post">
	<input type="hidden" name="m" value="checkplusSerivce">
	<input type="hidden" name="EncodeData" value="<c:out value="${niceIdResult.sEncData}"/>">
</form>

<script>
    $(function(){
        _page.init();
    });
	var _page ={
	    init:function(){
	        _mainScope.init();
		}
	};
	var _mainScope ={
	    init:function(){
			var _th = this;
			_th.button.btnAuth.click(function(){
			    _th.method.checkplusSerivce();
			});
		}
		,frm : {
	        plusForm:$("#plusForm")
		}
		,button :{
	        btnAuth :$("#btnAuth")
		},
		method : {
            checkplusSerivce :function(){
                window.open('','popupChk','width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
                _mainScope.frm.plusForm.attr("action","https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb");
                _mainScope.frm.plusForm.attr("target","popupChk");
                _mainScope.frm.plusForm.submit();
            },
	        callbackPlusService: function(data){
                if(data.resultKey == 0 && data.errorCode == null){
                    _mainScope.method.setDormancyUpdate();
                }else{
                    alert(data.message + " , "+data.errorCode);
                    return false;
                }
			},
			setDormancyUpdate:function(){
	            console.log("ajax 실행!");
                _ajaxUtils.request({
                    url: "/api/member/setDormancyUpdate.do",
                    data: {},
                    success: function (data) {
                        if(data > 0){
                            // 로그인 창으로 이동
                            layerMsgPopup.open({
                                title : "휴면 계정 알림"
                                ,content : "휴면계정 복구 완료하였습니다."
                                ,btnName : [{name:"확인",onClick:function(){location.href = "/member/login.do";}}]
                                ,width : 460
                            });

						}else{
                            // 오류 발생
                            // 로그인 창으로 이동
                            layerMsgPopup.open({
                                title : "휴면 계정 알림"
                                ,content : "오류가 발생하였습니다. 다시 시도 하시기 바랍니다."
                                ,btnName : [{name:"확인",onClick:function(){}}]
                                ,width : 460
                            });

						}

                    }

                });
			}
		}
	}



</script>