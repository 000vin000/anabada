document.addEventListener("DOMContentLoaded", () => {
    const itemNo = new URLSearchParams(window.location.search).get("tempNo"); // 상품상세페이지로 갔을때 넘버 가져오기
    const itemName = document.querySelector(".item-name").innerText; // 이름을 가져오려고 이너텍스트를 훔쳐오는 부분
    const itemImage = document.querySelector(".item-image").src; // 요소를 가져오는거부분 상세페이지에 맞춰서 수정되어야하는 부분

    if (itemNo) {
        addRecentView(itemNo, itemName, itemImage);
    }
}); // 스크립트 태그로 상세페이지에만 추가할것

// 아래는 현재 외부 js 파일채로 사이드바가 있는 페이지에 적용하기
// JavaScript로 쿠키에 상품 정보 저장
function addRecentView(itemNo, itemName, itemImage) {
    const maxItems = 5; // 최근 본 상품 최대 개수 설정
    const cookieName = "recentItems";

    // 기존 쿠키 값 가져오기
    let recentItems = getRecentItems();

    // 중복 제거 (이미 있는 상품이면 삭제)
    recentItems = recentItems.filter(item => item.tempNo !== itemNo); // 페이지의 아이템 넘버가 쿠키안에 들어있는거면 추가하지 않도록

    // 새로운 상품 추가
    recentItems.unshift({ id: itemNo, name: itemName, image: itemImage });

    // 최대 개수 초과 시 제거
    if (recentItems.length > maxItems) {
        recentItems.pop();
    }

    // JSON 문자열로 변환 후 쿠키 저장
    document.cookie = `${cookieName}=${encodeURIComponent(JSON.stringify(recentItems))}; path=/; max-age=${60 * 60 * 24 * 1};`;
}

// 쿠키에서 최근 본 상품 가져오기
function getRecentItems() {
    const cookieName = "recentItems=";
    const cookies = document.cookie.split("; ");
    
    for (let cookie of cookies) {
        if (cookie.startsWith(cookieName)) {
            return JSON.parse(decodeURIComponent(cookie.substring(cookieName.length))) || [];
        }
    }
    return [];
}

// 사이드바에 최근 본 상품 표시
function displayRecentProducts() {
    const recentProducts = getRecentItems();
    const sidebar = document.querySelector("#recent-products-sidebar");
    sidebar.innerHTML = ""; // 기존 내용 초기화

    recentProducts.forEach(product => {
        const item = document.createElement("div");
        item.innerHTML = `
            <a href="product.html?id=${product.id}">
                <img src="${product.image}" alt="${product.name}" width="50">
                <span>${product.name}</span>
            </a>
        `;
        sidebar.appendChild(item);
    });
}

// 페이지 로드 시 최근 본 상품 목록 표시
document.addEventListener("DOMContentLoaded", displayRecentProducts);
