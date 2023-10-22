import React from 'react';
import { BrowserRouter as Router, Route, Routes, BrowserRouter } from 'react-router-dom';
import { Login, ForgotPassword } from './pages/Auth';

const App = () => (
  <BrowserRouter>
    <Routes>
      <Route path="/login" element={<Login/>} />
      <Route path="/forgot-password" element={<ForgotPassword/>} />
    </Routes>
  </BrowserRouter>
);

export default App;
