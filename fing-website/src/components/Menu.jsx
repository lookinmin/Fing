import React from 'react'
import { useNavigate } from 'react-router-dom';

export const Menu = () => {

  let navigate = useNavigate();
  function handleClick(e) {
    if(e===1){
      navigate("/");
    }
    else if(e===2){
      navigate("/goods");
    }
    else{
      navigate("/about");
    }
  }
  return (
    <div className="menu">
      <ul>
        <li><a style={{"cursor": "pointer"}} onClick={() => handleClick(1)}>home</a></li>
        <li><a style={{"cursor": "pointer"}} onClick={() => handleClick(2)}>goods</a></li>
        <li><a style={{"cursor": "pointer"}} onClick={() => handleClick(3)}>about</a></li>
      </ul>
    </div>
  )
}
