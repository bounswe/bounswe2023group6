import React from 'react'
import { Route, Routes, BrowserRouter } from 'react-router-dom'
import { HomePage } from './pages/HomePage'
import { ChangePassword, ForgotPassword, Login, Signup } from './pages/Auth'
import { HomePage } from './pages/HomePage'

const App = () => (
	<BrowserRouter>
		<Routes>
			<Route path='/login' element={<Login />} />
			<Route path='/forgot-password' element={<ForgotPassword />} />
			<Route path='/home' element={<HomePage />} />
			<Route path='/signup' element={<Signup />} />
			<Route path='/change-password' element={<ChangePassword />} />
			<Route path='/home' element={<HomePage />} />
		</Routes>
	</BrowserRouter>
)

export default App
