import React from "react";
import { useNavigate } from "react-router-dom";

export const Menu = () => {
  const navigate = useNavigate();

  return (
    <div className="menu">
      <ul>
        <li style={{ cursor: "pointer" }}>
          <a onClick={() => navigate("/")}>home</a>
        </li>
        <li style={{ cursor: "pointer" }}>
          <a onClick={() => navigate("/goods")}>goods</a>
        </li>
        <li style={{ cursor: "pointer" }}>
          <a onClick={() => navigate("/about")}>about</a>
        </li>
      </ul>
    </div>
  );
};
