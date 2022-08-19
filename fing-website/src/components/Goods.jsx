import React from 'react'
import { Menu } from './Menu'
import { IoLogoGooglePlaystore } from "react-icons/io5";

export const Goods = () => {
  return (
    <div className="goods">
      <div className="h2">아니 시비라 어띠</div>
      <h2 id='logo' className='white'>Fing Market</h2>
      <Menu/>

      <div className="toDownload">
        <img src="./img/fingLogo.png" alt="fing" height="70px"/>
        <h2 style={{paddingRight : "15px"}}>Fing Download</h2>
        <IoLogoGooglePlaystore color='#fff' size={40} />
      </div>
    </div>
  )
}
