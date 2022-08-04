import React from 'react'

export const Home = () => {
  return (
    <div className="home">
      <div className='mainPage'>
        <h2 id='logo'>Fing</h2>
        <div className="top">
          <h2>페스티벌이 궁금해?</h2>
          <h2>Fing 찍어!</h2>
        </div>
      </div>

      <div className="toDownload">
        <img src="./img/fingLogo.png" alt="fing" height="70px"/>
        <h2>Fing Download</h2>
        <img id='goPS' src="./img/playstore.png" alt="fing" height="30px"/>
      </div>

      <div className="exOne">
        <div className="txtBox">
          <h2>페스티벌이 열리는 모든곳에</h2>
          <h3>페스티벌에 대한 정보는</h3>
          <h3><span className='t1'>Fing</span>과 함께</h3>
        </div>

      </div>

      
      <div className="exOne">
        <div className="txtBox">
          <h2>지역 소상공인들을 위한</h2>
          <h3>상생하는 페스티벌은</h3>
          <h3><span className='t1'>Fing</span>과 함께</h3>
        </div>

      </div>

      <div className="exOne">
        <div className="txtBox">
          <h2>페스티벌만 보고 갈거야?</h2>
          <h3>근처 놀거리 먹거리 역시</h3>
          <h3><span className='t1'>Fing</span>과 함께</h3>
        </div>

      </div>

    </div>
    

  )
}
