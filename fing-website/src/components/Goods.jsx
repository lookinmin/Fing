import React from 'react'
import { Menu } from './Menu'
import { IoLogoGooglePlaystore } from "react-icons/io5";
import { Footer } from './Footer';
import { useMediaQuery } from 'react-responsive';

export const Goods = () => {
  const isNormal = useMediaQuery({minWidth : 1550})
  const isTooBig = useMediaQuery({maxWidth:1549.9999, minWidth:1000})
  const isSmall = useMediaQuery({maxWidth:999.999})
  return (
    <div className="goods">
      <div className="txtForTop">
        <h2>F-ING Market</h2>
      </div>
      {isNormal &&
        <div className="goodsItems">
          <div id="item1">
            <h2>F-ING 텀블러</h2>
            <div className="pic-ctn">
              <img src="https://picsum.photos/200/300?t=1" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=2" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=3" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=4" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=5" alt="" class="pic"></img>
            </div>
          
            <div className='GtxtBox'>
              <h3>KRW 5,000</h3>
              <p>Fing 로고가 박힌 심플 텀블러</p>
              <p>페스티벌을 깨끗하게 즐기는 하나의 방법.</p>
              <p>Fing 텀블러와 함께 페스티벌을 즐겨보세요</p>
              <p></p>
            </div>
            <div id="container">
              <button className="learn-more">
                <span className="circle" aria-hidden="true">
                  <span className="icon arrow"></span>
                </span>
                <span className="button-text">구매하러 앱으로 이동하기</span>
              </button>
            </div>
          </div>
          <div id="item2">
            <h2>F-ING 에코백</h2>
            <div className="pic-ctn">
              <img src="https://picsum.photos/200/300?t=1" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=2" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=3" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=4" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=5" alt="" class="pic"></img>
            </div>
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
      }
      {(isTooBig || isSmall) &&
        <div className="goodsItems2">
          <div id="item1">
            <h2>F-ING 텀블러</h2>
            <div className="pic-ctn">
              <img src="https://picsum.photos/200/300?t=1" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=2" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=3" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=4" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=5" alt="" class="pic"></img>
            </div>
          
            <div className='GtxtBox'>
              <h3>KRW 5,000</h3>
              <p>Fing 로고가 박힌 심플 텀블러</p>
              <p>페스티벌을 깨끗하게 즐기는 하나의 방법.</p>
              <p>Fing 텀블러와 함께 페스티벌을 즐겨보세요</p>
              <p></p>
            </div>
            <div id="container">
              <button className="learn-more">
                <span className="circle" aria-hidden="true">
                  <span className="icon arrow"></span>
                </span>
                <span className="button-text">구매하러 앱으로 이동하기</span>
              </button>
            </div>
          </div>
          <div id="item2">
            <h2>F-ING 에코백</h2>
            <div className="pic-ctn">
              <img src="https://picsum.photos/200/300?t=1" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=2" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=3" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=4" alt="" class="pic"></img>
              <img src="https://picsum.photos/200/300?t=5" alt="" class="pic"></img>
            </div>
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
      }
      

     
      
      
      <Menu/>

      
      {isNormal && 
        <div className="toDownload">
          <img src="./img/fingLogo.png" alt="fing" height="70px"/>
          <h2 style={{paddingRight : "15px"}}>Fing Download</h2>
          <IoLogoGooglePlaystore color='#fff' size={40} />
        </div>
      }
      {isTooBig &&
        <div className="toDownload">
          <img src="./img/fingLogo.png" alt="fing" height="50px"/>
          <h2 style={{paddingRight : "10px", fontSize: "1.3rem"}}>Fing Download</h2>
          <IoLogoGooglePlaystore color='#fff' size={30} />
        </div>
      }
      {isSmall &&
        <div className="toDownload">
          <img src="./img/fingLogo.png" alt="fing" height="50px"/>
          <h2 style={{paddingRight : "10px", fontSize: "1.3rem"}}>Download</h2>
          <IoLogoGooglePlaystore color='#fff' size={25} />
        </div>
      }
      <Footer/>
    </div>


  )
}