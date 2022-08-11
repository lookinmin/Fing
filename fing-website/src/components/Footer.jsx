import React from 'react'

export const Footer = () => {


  const move=(e)=> {
    switch (e){
      case 1:
        window.open('https://www.instagram.com/lookin_min/');
        break;
      case 2:
        window.open('https://www.apple.com/kr/app-store/');
        break;
      case 3:
        window.open('https://play.google.com/store/games?hl=ko');
        break;
      case 4:
        window.open('https://github.com/lookinmin/Fing');
        break;
    }
  }

  
  return (
    <div className="footer">
      <div className="pageIcons">
        <img className='icons' src="./img/instagram.png"  onClick={() => move(1)} alt="fing insta"  height="40px"/>
        <img className='icons' src="./img/app-store.png"  onClick={() => move(2)} alt="fing insta" height="40px"/>
        <img className='icons' src="./img/playstore.png"  onClick={() => move(3)} alt="fing insta" height="40px"/>
        <img className='icons' src="./img/github.png" onClick={() => move(4)} alt="fing insta" height="40px"/>
      </div>
      <div className="footerLogo">
        <h2>Fing : Festival-ing</h2>
      </div>

      <div className="txts">
        <div className="div1">
          <p><span className='TT'>Address.</span>충청북도 청주시 서원구 충대로 1 충북대학교 S1-4 116호</p>
          <p><span className='TT'>Team.</span>2022 관광데이터 활용 공모전 본선 진출팀 : 핑퐁</p>
          
        </div>
        
        <div className="div2">
          <p><span className='TT'>E-mail.</span>sncalphs@gmail.com</p>
          <p><span className='TT'>Instagram.</span>@lookin_min</p>
        </div>
        
        <div className="div3">
          <p><span className='TT'>Leader.</span>조민수</p>
          <p>@ Copyright 2022 Fing All rights reserved</p>
        </div>
      </div>

      
    </div>
  )
}
