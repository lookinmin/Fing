import React from 'react'
import { Footer } from './Footer'
import { Menu } from './Menu'
import { MdRoom } from 'react-icons/md';
import styles from './Home.module.css';
import { useRef, useState, useEffect } from 'react';
import { useIntersectionObserver } from './useIntersectionObserver.ts';
import { IoAnalyticsOutline,IoPartlySunnyOutline, IoHeartOutline } from "react-icons/io5";



export const Home = () => {

  const [scrollPosition, setScrollPosition] = useState(0);
  const updateScroll = () => {
      setScrollPosition(window.scrollY || document.documentElement.scrollTop);
  }
  useEffect(()=>{
      window.addEventListener('scroll', updateScroll);
  });

  const moveTop = () => {
    window.scrollTo({top: 0, behavior : "smooth"});
  }
   




  const target1 = useRef(null)
  const target2 = useRef(null)
  const target3 = useRef(null)
  const target4 = useRef(null)

  useIntersectionObserver(target1, styles.animation);
  useIntersectionObserver(target2, styles.animation);
  useIntersectionObserver(target3, styles.animation);
  useIntersectionObserver(target4, styles.animation);

  return (
    <div className="home">
      <div className='mainPage'>
        <h2 id='logo' onClick={() => moveTop()} className={scrollPosition < 900 ? "white" : "orange"}>Fing</h2>
        <div className="top">
          <h2>페스티벌이 궁금해?</h2>
          <h2>Fing 찍어<MdRoom size="50"/></h2>
        </div>
      </div>

      <Menu/>

      <div className="toDownload">
        <img src="./img/fingLogo.png" alt="fing" height="70px"/>
        <h2>Fing Download</h2>
        <img id='goPS' src="./img/playstore.png" alt="fing" height="30px"/>
      </div>

      <div className="txtsBox">
        <h2 id='y1'>페스티벌은?</h2>
        <h2 id='y2'>Let's <span className='t1' ref={target1}>Fing</span><MdRoom size="50" color= 'rgb(255, 126, 0)'/></h2>
      </div>

      <div className="itemsList">
        <div className="items">
          <div className="box">
            <span className='icons'><IoPartlySunnyOutline size="50"/></span>
          </div>
          <h2><span className='t1'>계절</span>별로 즐기는 페스티벌</h2>
        </div>
        <div className="items">
          <div className="box">
            <span className='icons'><IoHeartOutline size="50"/></span>
          </div>
          <h2>관심있는 페스티벌을 <span className='t1'>찜</span></h2>
        </div>
        <div className="items">
          <div className="box">
            <span className='icons'><IoAnalyticsOutline size="50"/></span>
          </div>
          <h2><span className='t1'>Hot</span>한 페스티벌은?</h2>
        </div>
      </div>

      <div className="exOne">
        <div className="txtBox">
          <h2>페스티벌이 열리는 모든곳에</h2>
          <h3>페스티벌에 대한 정보는</h3>
          <h3><span className='t1' ref={target2}>Fing</span>과 함께</h3>
        </div>

      </div>

      
      <div className="exOne">
        <div className="txtBox">
          <h2>지역 소상공인들을 위한</h2>
          <h3>상생하는 페스티벌은</h3>
          <h3><span className='t1' ref={target3}>Fing</span>과 함께</h3>
        </div>

      </div>

      <div className="exOne">
        <div className="txtBox">
          <h2>페스티벌만 보고 갈거야?</h2>
          <h3>근처 놀거리 먹거리 역시</h3>
          <h3><span className='t1' ref={target4}>Fing</span>과 함께</h3>
        </div>

      </div>


     <Footer></Footer>

    </div>

    
    

  )
}
