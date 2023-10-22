import React from 'react';
import "../../index.css"

const Login = () => (
  <form>
    <h1>Login</h1>
    <input type="text" placeholder="Username" />
    <input type="password" placeholder="Password" />
    <button className="btn" type="submit">Login</button>
  </form>
);

export default Login;
