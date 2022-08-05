import React from 'react'

export const Footer = () => {
  return (
    <div className="footer">
      <div className="pageIcons">
        <img className='icons' src="./img/instagram.png" alt="fing insta"  height="40px"/>
        <img className='icons' src="./img/app-store.png" alt="fing insta" height="40px"/>
        <img className='icons' src="./img/playstore.png" alt="fing insta" height="40px"/>
        <img className='icons' src="./img/github.png" alt="fing insta" height="40px"/>
      </div>
    <div className="footerLogo">
      <h2>Fing : Festival-ing</h2>
    </div>
    <div className="txts">
      <p><span className='TT'>Address.</span>충청북도 청주시 서원구 충대로 1 충북대학교 S1-4 107호</p>
      <p>@ Copyright 2022 Fing All rights reserved</p>
    </div>
    </div>
  )
}
