import React from 'react'
import { IoLogoInstagram, IoLogoGithub } from "react-icons/io5";
import { GrAppleAppStore } from "react-icons/gr";
import { useMediaQuery } from 'react-responsive';
import { RiKakaoTalkFill, RiGooglePlayFill } from "react-icons/ri";
import { useNavigate } from 'react-router-dom';

export const Footer = () => {

  const isntShort = useMediaQuery({minWidth : 1450})
  const isShort = useMediaQuery({maxWidth : 1449.99999, minWidth : 1300})
  const isPhone = useMediaQuery({maxWidth : 1299.99999})

  const move=(e)=> {
    switch (e){
      case 1:
        window.open('https://www.instagram.com/festival_ing/');
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
      case 5:
        window.open('http://pf.kakao.com/_jMfVxj');
        break;
    }
  }

  let navigate = useNavigate();
  function handleClick(e) {
    if(e===1){
      navigate("/personal");
    }
    else{
      navigate("/service")
    }
  
  }

  
  return (
    <>
      {isntShort &&
        <div className="footer">
          <div className="pageIcons">
            <IoLogoInstagram color='#faf5e4' size={40} onClick={() => move(1)}/>
            <GrAppleAppStore color='#faf5e4' size={40} onClick={() => move(2)}/>
            <RiGooglePlayFill color='#faf5e4' size={40} onClick={() => move(3)}/>  
            <IoLogoGithub color='#faf5e4' size={40} onClick={() => move(4)}/>
            <RiKakaoTalkFill color='#faf5e4' size={40} onClick={() => move(5)}/>
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
              <p><span className='TT'>Instagram.</span>@festival_ing</p>
            </div>
            
            <div className="div3">
              <p><span className='TT'>Leader.</span>조민수</p>
            </div>
          </div>

          <div className="txtz2">
            <p>@ Copyright 2022 Fing All rights reserved</p>
            <p onClick={() => handleClick(1)}>개인정보 처리방침</p>
            <p onClick={() =>handleClick(2)}>서비스 이용약관</p>
          </div>
        </div>
      }
      {isShort &&
        <div className="footer2">
          <div className="pageIcons">
            <IoLogoInstagram color='#faf5e4' size={40} onClick={() => move(1)}/>
            <GrAppleAppStore color='#faf5e4' size={40} onClick={() => move(2)}/>
            <RiGooglePlayFill color='#faf5e4' size={40} onClick={() => move(3)}/>  
            <IoLogoGithub color='#faf5e4' size={40} onClick={() => move(4)}/>
            <RiKakaoTalkFill color='#faf5e4' size={40} onClick={() => move(5)}/>
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
            </div>
          </div>

          <div className="txtz2">
            <p>@ Copyright 2022 Fing All rights reserved</p>
            <p>개인정보 처리방침</p>
            <p>서비스 이용약관</p>
          </div>
        </div>

      }
      {isPhone &&
        <div className="footer3">
          <div className="pageIcons">
          <IoLogoInstagram color='#faf5e4' size={40} onClick={() => move(1)}/>
            <GrAppleAppStore color='#faf5e4' size={40} onClick={() => move(2)}/>
            <RiGooglePlayFill color='#faf5e4' size={40} onClick={() => move(3)}/>  
            <IoLogoGithub color='#faf5e4' size={40} onClick={() => move(4)}/>
            <RiKakaoTalkFill color='#faf5e4' size={40} onClick={() => move(5)}/>
          </div>
          <div className="footerLogo">
            <h2>Fing : Festival-ing</h2>
          </div>

          <div className="txts2">
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
            </div>
          </div>

          <div className="txtz2">
            <p>@ Copyright 2022 Fing All rights reserved</p>
            <p>개인정보 처리방침</p>
            <p>서비스 이용약관</p>
          </div>
        </div>
      }
    </>
   
    
  )
}
