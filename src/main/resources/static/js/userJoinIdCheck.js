$(document).ready(function() {
    // 아이디 중복 체크 (버튼 클릭 시)
    $('#checkDuplicateUserId').click(function() {
        checkDuplicate('userId', $('#userId').val(), '#userIdCheckResult');
    });

    // 닉네임 중복 체크 (입력 즉시)
    $('#userNick').on('input', function() {
        checkDuplicate('userNick', $(this).val(), '#userNickCheckResult');
    });

    // 이메일 중복 체크 (입력 즉시)
    $('#userEmail').on('input', function() {
        checkDuplicate('userEmail', $(this).val(), '#userEmailCheckResult');
    });

    // 전화번호 중복 체크 (입력 즉시)
	$('#userPhone1, #userPhone2, #userPhone3').on('input', function() {
	    const phone1 = $('#userPhone1').val();
	    const phone2 = $('#userPhone2').val();
	    const phone3 = $('#userPhone3').val();

	    // 전화번호가 모두 입력되었을 때만 확인
	    if (phone1.length === 3 && (phone2.length === 3 || phone2.length === 4) && phone3.length === 4) {
	        const fullPhone = `${phone1}${phone2}${phone3}`; // "-" 없이 조합
	        checkDuplicate('userPhone', fullPhone, '#userPhoneCheckResult');
	    } else {
	        // 입력이 완성되지 않은 경우 메시지 숨김
	        $('#userPhoneCheckResult').text('');
	    }
	});


    function checkDuplicate(field, value, resultSelector) {
        if (!value) {
            showMessage(`${getFieldName(field)}를 입력해주세요.`, 'red', resultSelector);
            return;
        }

        $.ajax({
            url: `/user/check-duplicate/${field}`,
            type: 'GET',
            data: { value: value },
			success: function(response) {
			    if (response.invalidFormat) {
			        showMessage('올바른 전화번호 형식이 아닙니다.', 'red', resultSelector);
			    } else if (response.isDuplicate) {
			        showMessage(`사용할 수 없는 ${getFieldName(field)}입니다.`, 'red', resultSelector);
			    } else {
			        $(resultSelector).text(''); // 중복이 아닌 경우 메시지 숨김
			    }
			},

            error: function() {
                showMessage('중복 확인 중 오류가 발생했습니다.', 'red', resultSelector);
            }
        });
    }

    function showMessage(message, color, target) {
        $(target).text(message).css('color', color);
    }

    function getFieldName(field) {
        switch(field) {
            case 'userId': return '아이디';
            case 'userNick': return '닉네임';
            case 'userEmail': return '이메일';
            case 'userPhone': return '전화번호';
            default: return field;
        }
    }
});
