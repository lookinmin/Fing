import { Menu } from './Menu';
import React, { useState, useEffect, useRef } from 'react';
import $ from 'jquery';
import { useMediaQuery } from 'react-responsive';
import { useNavigate } from 'react-router-dom';


export const About = () => {
  const isMax = useMediaQuery({minWidth : 1360})
  const isMin = useMediaQuery({maxWidth : 1359.999})

  const [scrollPosition, setScrollPosition] = useState(0);      //현재 스크롤 하는 부분이 어딘지 받아올 State
  const updateScroll = () => {
    setScrollPosition(window.scrollY || document.documentElement.scrollTop);
  }
  useEffect(()=>{
      window.addEventListener('scroll', updateScroll);
  });
  class Scroll extends React.Component{
    constructor() {
      super();
        this.state = {
          scrollTop: 0
        }
    }
       
    componentDidMount = () => {
      window.addEventListener('scroll', this.handleScroll);
    }
    componentWillUnMount = () => {
      window.removeEventListener('scroll', this.handleScroll);
    }

    handleScroll = () => {
      const scrollTop = ('scroll', scrollPosition);
      this.setState({
        scrollTop
      })

    
      if(450 > scrollTop && scrollTop > 0){
        const y1 = $(".men1").offset().top;
        window.scrollTo({top : y1, behavior: "smooth"});
        console.log("일단해" + 11)
      }
      else if(1500 > scrollTop && scrollTop >= 450){
        const y2 = $(".men2").offset().top;
        window.scrollTo({top : y2, behavior: "smooth"});
        //$('body,html').animate({scrollTop:$(".men2").offset().top}, 2000);
        console.log("일단해" + 22)
      }
      else if(2700 > scrollTop && scrollTop >= 1500){
        const y3 = $(".men3").offset().top;
        window.scrollTo({top : y3, behavior: "smooth"});
        console.log("일단해" + 33)
      }
      else if(scrollTop >= 2700){
        const y4 = $(".men4").offset().top;
        window.scrollTo({top : y4, behavior: "smooth"});
        console.log("일단해" + 44)
      }
    }

  }

  const scr = new Scroll();

  function scrollToTop(){
    //스크롤 속도를 빠르게 하려면 이동 간격 시간을 줄이거나, 이동 크기 픽셀을 늘리면 됩니다.
    let between = 16; // 이동 간격 시간
    let scroll = window.setInterval(function() {
      let pos = window.pageYOffset;
      let step = 15; // 이동 크기 픽셀
      if ( pos > 0 ) {
          window.scrollTo( 0, pos - step );
      } else {
          window.clearInterval( scroll );
      }
    }, between);
  }


  let navigate = useNavigate();
  function handleClick(e) {
    if(e===1){
      navigate("/goods");
    }
  }

  return (
    
    <div className='aboutDiv' onScroll={scr.handleScroll()}>
      <h2 id='logo' onClick={() => scrollToTop()} className="white">Fing</h2>
      {isMax &&
      <>
        <div className="men1" >
          <Menu/>
          <div className="aboutTxt1" id='target1' >
            <h2>페스티벌이 있는 모든 곳에</h2>
            <h2 className='t2'>Fing : Festival - ing</h2>
          </div>
        </div>
        <div className="men2" >
          <div className="aboutTxt2" id='target2'>
            <h2>페스티벌 굿즈도 <span className='t2'>Fing</span>과 함께</h2>
            <h2><span className='t2'>Fing</span> 텀블러와 에코백으로 환경까지</h2>
          </div>
          <a id="button-1" class="buttonSS" style={{"cursor": "pointer"}} onClick={()=>handleClick(1)}>F-ING Market<img id="arrow-hover" src="https://github.com/atloomer/atloomer.github.io/blob/master/img/iconmonstr-paper-plane-1-120.png?raw=true"/></a>
        </div>
        <div className="men3">
          <div className="aboutTxt3" id='target3'>
            <h2>당신의 페스티벌?<span className='t2'> Fing</span>과 함께</h2>
            <h2>페스티벌 공유 & 홍보 역시 <span className='t2'> Fing</span></h2>
          </div>
        </div>
        <div className="men4" >
          <div className="aboutTxt4" id='target4'>
            <h2><span className='t2'>Fing</span>은 Tour API 4.0과 함께 합니다.</h2>
            <h2>페스티벌이 있는 곳엔? 역시 <span className='t2'>Fing</span></h2>
          </div>
        </div>
      </> 
      }
      {isMin && 
      <>
        <div className="men1" >
         <Menu/>
         <div className="aboutTxt1" id='target1' style={{fontSize : "2rem"}} >
           <h2>페스티벌이 있는 모든 곳에</h2>
           <h2 className='t2'>Fing : Festival - ing</h2>
         </div>
        </div>
        <div className="men2" >
          <div className="aboutTxt2" id='target2' style={{fontSize : "2rem", marginLeft: "6vw"}}>
            <h2>페스티벌 굿즈도 <span className='t2'>Fing</span>과 함께</h2>
            <h2><span className='t2'>Fing</span> 굿즈로 환경까지</h2>
          </div>
          <a id="button-1" class="buttonSS2" onClick={()=>handleClick(1)}>F-ING Market<img id="arrow-hover" src="https://github.com/atloomer/atloomer.github.io/blob/master/img/iconmonstr-paper-plane-1-120.png?raw=true"/></a>
        </div>
        <div className="men3">
          <div className="aboutTxt3" id='target3' style={{fontSize : "2rem", marginLeft: "6rem"}}>
            <h2>당신의 페스티벌?<span className='t2'> Fing</span>과 함께</h2>
            <h2>페스티벌 공유 & 홍보 역시 <span className='t2'> Fing</span></h2>
          </div>
        </div>
        <div className="men4" >
          <div className="aboutTxt4" id='target4' style={{fontSize : "2rem"}}>
            <h2><span className='t2'>Fing</span>은 Tour API 4.0과 함께 합니다.</h2>
            <h2>페스티벌이 있는 곳엔? 역시 <span className='t2'>Fing</span></h2>
          </div>
        </div>
     </> 
      }
    </div>
      
  )
}
