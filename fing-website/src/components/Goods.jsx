import React from 'react'
import { Menu } from './Menu'
import { IoLogoGooglePlaystore } from "react-icons/io5";
import { Footer } from './Footer';



export const Goods = () => {
  return (
    <div className="goods">
      <div className="txtForTop">
        <h2>F-ING Market</h2>
      </div>
      
      <div className="goodsItems">
        <div id="item1">
          <h2>F-ING 텀블러</h2>
          <img src="./img/fingLogo.png" alt="fing텀블러" height="300px"/>
          <div className='GtxtBox'>
            <h3>KRW 5,000</h3>
            <p>Fing 로고가 박힌 심플 텀블러</p>
            <p>페스티벌을 깨끗하게 즐기는 하나의 방법.</p>
            <p>Fing 텀블러와 함께 페스티벌을 즐겨보세요</p>
            <p></p>
          </div>
          <div id="container">
            <button class="learn-more">
              <span class="circle" aria-hidden="true">
                <span class="icon arrow"></span>
              </span>
              <span class="button-text">구매하러 앱으로 이동하기</span>
            </button>
          </div>
        </div>
        <div id="item2">
          <h2>F-ING 에코백</h2>
          <img src="./img/fingLogo.png" alt="fing에코백" height="300px"/>
          <div className='GtxtBox'>
            <h3>KRW 7,000</h3>
            <p>Fing 로고가 박힌 화이트 에코백</p>
            <p>페스티벌을 깨끗하게 즐기는 하나의 방법.</p>
            <p>Fing 에코백와 함께 페스티벌을 즐겨보세요</p>
            <p></p>
          </div>
          <div id="container">
            <button class="learn-more">
              <span class="circle" aria-hidden="true">
                <span class="icon arrow"></span>
              </span>
              <span class="button-text">구매하러 앱으로 이동하기</span>
            </button>
          </div>
        </div>
      </div>

     
      
      
      <Menu/>

      <div className="toDownload">
        <img src="./img/fingLogo.png" alt="fing" height="70px"/>
        <h2 style={{paddingRight : "15px"}}>Fing Download</h2>
        <IoLogoGooglePlaystore color='#fff' size={40} />
      </div>
      <Footer/>
    </div>


  )
}
