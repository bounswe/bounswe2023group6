import React from 'react'
import { Route, Routes, BrowserRouter } from 'react-router-dom'
import { HomePage } from './pages/HomePage'
import { GamePage } from './pages/GamePage'
import { ProfilePage } from './pages/Profile'
import { ResetPassword, ForgotPassword, Login, Signup } from './pages/Auth'
import { ForumPage } from './pages/ForumPage'
import { PostPage } from './pages/PostPage'
import { NextUIProvider } from '@nextui-org/react'
import { GameForum } from './pages/GameForum'
import { LfgPage } from "./pages/LfgPage";
import { AdminPanel } from './pages/AdminPanel'

const App = () => (
	<NextUIProvider disableBaseline='true'>
		<BrowserRouter>
			<Routes>
				<Route exact path='/' element={<HomePage />} />
				<Route path='/login' element={<Login />} />
				<Route path='/profile-page' element={<ProfilePage />} />
				<Route path='/forgot-password' element={<ForgotPassword />} />
				<Route path='/signup' element={<Signup />} />
				<Route path='/reset-password' element={<ResetPassword />} />
				<Route path='/home' element={<HomePage />} />
				<Route path='/forum' element={<ForumPage />} />
				<Route path='/groups' element={<LfgPage />} />
				<Route path='/game' element={<GameForum />} />
				<Route path='/game/:gameId' element={<GamePage />} />
				<Route path='/posts/:postId' element={<PostPage />} />
				<Route path='/admin-panel' element={<AdminPanel />} />
			</Routes>
		</BrowserRouter>
	</NextUIProvider>
)

export default App
