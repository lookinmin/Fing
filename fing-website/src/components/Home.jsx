import { Footer } from './Footer'
import { Menu } from './Menu'
import { MdRoom } from 'react-icons/md';
import styles from './Home.module.css';
import { useMediaQuery } from 'react-responsive';
import React, { useRef, useState, useEffect } from 'react';
import { useIntersectionObserver } from './useIntersectionObserver.ts';
import { IoAnalyticsOutline,IoPartlySunnyOutline, IoHeartOutline,IoLogoGooglePlaystore } from "react-icons/io5";


export const Home = () => {
  const [scrollPosition, setScrollPosition] = useState(0);      //현재 스크롤 하는 부분이 어딘지 받아올 State
  const updateScroll = () => {
    setScrollPosition(window.scrollY || document.documentElement.scrollTop);
  }
  useEffect(()=>{
      window.addEventListener('scroll', updateScroll);
  });

  const isNormal = useMediaQuery({minWidth : 1600})
  const isTooBig = useMediaQuery({maxWidth:1599.9999, minWidth:1000})
  const isSmall = useMediaQuery({maxWidth:999.999})

  const isCom = useMediaQuery({minWidth : 1100})
  const isPhone = useMediaQuery({maxWidth : 1099.999})

  const isHaddan = useMediaQuery({minWidth : 1300})
  const isNewHaddan = useMediaQuery({maxWidth : 1299.999})

  const moveTop = () => {                                   //로고 누르면 최상단으로 이동하는 코드
    window.scrollTo({top: 0, behavior : "smooth"});
  }
   
  const target1 = useRef(null)
  const target2 = useRef(null)
  const target3 = useRef(null)
  const target4 = useRef(null)

  const img1 = useRef(null)
  const img2 = useRef(null)
  const img3 = useRef(null)
                                                                  //스크롤 구간에 맞춰 Fing 글자 Fade IN
  useIntersectionObserver(target1, styles.animation);
  useIntersectionObserver(target2, styles.animation);
  useIntersectionObserver(target3, styles.animation);
  useIntersectionObserver(target4, styles.animation);

  useIntersectionObserver(img1, styles.imgAni);
  useIntersectionObserver(img2, styles.imgAni);
  useIntersectionObserver(img3, styles.imgAni);

  return (
    <div className="home">
      <div className='mainPage'>
        <h2 id='logo' onClick={() => moveTop()} className={scrollPosition < 1050 ? "white" : "orange"}>Fing</h2>
        {isCom &&
          <div className="top">
            <h2 >페스티벌이 궁금해?</h2>
            <h2 ><span className='t2' >Fing</span> 찍어<MdRoom size="50"/></h2>
          </div>
        }
        {isPhone &&
          <div className="top2">
            <h2 style={{fontSize : "3rem", marginLeft: "0"}}>페스티벌이 궁금해?</h2>
            <h2  style={{fontSize : "3rem", marginLeft: "0"}}><span className='t2'>Fing</span> 찍어<MdRoom size="40"/></h2>
          </div>
        }
        
      </div>

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

      {isCom && 
      <>
        <div className="exOne">
          <div className="txtBox">
            <h2>페스티벌이 열리는 모든곳에</h2>
            <h3>페스티벌에 대한 정보는</h3>
            <h3><span className='t1' ref={target2}>Fing</span>과 함께</h3>
          </div>
          <img className='homeImg' ref={img1} src="./img/pic1.jpg" height="500px" alt="" />
        </div>

    
        <div className="exOne">
          <div className="txtBox">
            <h2>지역 소상공인들을 위한</h2>
            <h3>상생하는 페스티벌은</h3>
            <h3><span className='t1' ref={target3}>Fing</span>과 함께</h3>
          </div>
          <img className='homeImg' ref={img2} src="./img/pic2.jpg" height="500px" alt="" />
        </div>

        <div className="exOne">
          <div className="txtBox">
            <h2>페스티벌만 보고 갈거야?</h2>
            <h3>근처 놀거리 먹거리 역시</h3>
            <h3><span className='t1' ref={target4}>Fing</span>과 함께</h3>
          </div>
          <img className='homeImg' ref={img3} src="./img/pic3.jpg" height="500px" alt="" />
        </div>
      </>
      }

      {isPhone &&
      <>
        <div className="exOne2">
          <div className="txtBox">
            <h2>페스티벌이 열리는 모든곳에</h2>
            <h3>페스티벌에 대한 정보는</h3>
            <h3><span className='t1' ref={target2}>Fing</span>과 함께</h3>
          </div>
          <img className='homeImg' ref={img1} src="./img/pic1.jpg" height="400px" alt="" />
        </div>

    
        <div className="exOne2">
          <div className="txtBox">
            <h2>지역 소상공인들을 위한</h2>
            <h3>상생하는 페스티벌은</h3>
            <h3><span className='t1' ref={target3}>Fing</span>과 함께</h3>
          </div>
          <img className='homeImg' ref={img2} src="./img/pic2.jpg" height="400px" alt="" />
        </div>

        <div className="exOne2">
          <div className="txtBox">
            <h2>페스티벌만 보고 갈거야?</h2>
            <h3>근처 놀거리 먹거리 역시</h3>
            <h3><span className='t1' ref={target4}>Fing</span>과 함께</h3>
          </div>
          <img className='homeImg' ref={img3} src="./img/pic3.jpg" height="400px" alt="" />
        </div>
      </> 
      }
      
      {isHaddan && 
        <div className="haddan">
          <div className="txtsBox">
            <h2 id='y1'>페스티벌은?</h2>
            <h2 id='y2'>Let's <span className='t1' ref={target1}>Fing<MdRoom size="60" color= 'rgb(255, 126, 0)'/></span></h2>
          </div>

          <div className="itemsList">
            <div className="items">
              <div className="box">
                <span className='icons'><IoPartlySunnyOutline size="50"/></span>
              </div>
              <h2><span className='t2'>계절</span>별로 즐기는 페스티벌</h2>
            </div>
            <div className="items">
              <div className="box">
                <span className='icons'><IoHeartOutline size="50"/></span>
              </div>
              <h2>관심있는 페스티벌을 <span className='t2'>찜</span></h2>
            </div>
            <div className="items">
              <div className="box">
                <span className='icons'><IoAnalyticsOutline size="50"/></span>
              </div>
              <h2><span className='t2'>Hot</span>한 페스티벌은?</h2>
            </div>
          </div>

        </div>
      }
      {isNewHaddan && 
        <div className="haddan">
          <div className="txtsBox2">
            <h2 id='y1'>페스티벌은?</h2>
            <h2 id='y2'>Let's <span className='t1' ref={target1}>Fing<MdRoom size="35" color= 'rgb(255, 126, 0)'/></span></h2>
          </div>

          <div className="itemsList2">
            <div className="items">
              <div className="box">
                <span className='icons'><IoPartlySunnyOutline size="50"/></span>
              </div>
              <h2><span className='t2'>계절</span>별로 즐기는 페스티벌</h2>
            </div>
            <div className="items">
              <div className="box">
                <span className='icons'><IoHeartOutline size="50"/></span>
              </div>
              <h2>관심있는 페스티벌을 <span className='t2'>찜</span></h2>
            </div>
            <div className="items">
              <div className="box">
                <span className='icons'><IoAnalyticsOutline size="50"/></span>
              </div>
              <h2><span className='t2'>Hot</span>한 페스티벌은?</h2>
            </div>
          </div>
        </div>
      }

      
     <Footer></Footer>

    </div>

    
    

  )
}
