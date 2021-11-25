const stars = document.querySelector(".ratings").children; // class = "ratings"の子要素を取得
const ratingValue = document.getElementById("rating-value"); //id = "rating-value"の要素を取得
const ratingValueDisplay = document.getElementById("rating-value-display"); // id = "rating-value-display"の要素を取得

let index; // indexという変数を定義

// reviewの投稿ページに遷移するとstars.lengthの値（5）だけ繰り返し
for(let i=0; i<stars.length; i++){  

  // 以下マウスが星に乗った時の処理.5回繰り返される
  stars[i].addEventListener("mouseover", function(){
    for(let j=0; j<stars.length; j++){
      stars[j].classList.remove("fa-star"); //classlist：特定の要素にクラス名を追加したり削除したりできるプロパティ
      stars[j].classList.add("fa-star-o"); //まず一旦全部の星をくり抜く
    }
    for(let j=0; j<=i; j++){ //その後星の数だけ以下の関数が繰り返される
      stars[j].classList.remove("fa-star-o"); 
      stars[j].classList.add("fa-star"); //カーソルが乗ったところまで塗りつぶす
    }
  })
  
  //以下クリックした時の処理
  stars[i].addEventListener("click",function(){ 
    ratingValue.value = i + 1; // クリックされた星の番号+1をratingValueに代入
    ratingValueDisplay.textContent = ratingValue.value;
    index = i; // indexにクリックされた星の番号を代入
  })

  //以下マウスアウトした時の処理
  stars[i].addEventListener("mouseout", function(){ 
    for(let j=0; j<stars.length; j++){
      stars[j].classList.remove("fa-star"); 
      stars[j].classList.add("fa-star-o"); 
    }
    for(let j=0; j<=index; j++){ //index→クリックされた星まで
      stars[j].classList.remove("fa-star-o"); 
      stars[j].classList.add("fa-star");
    }
  })

}