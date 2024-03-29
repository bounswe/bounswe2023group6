import React, { useState, useEffect } from 'react'
import SubMenu from './SubMenu'
import * as IoIcons from 'react-icons/io'
import Topbar from './Topbar'
import axios from 'axios'
import { useNavigate } from 'react-router-dom'

const Sidebar = () => {
	const api_url = process.env.REACT_APP_API_URL;
	const navigate = useNavigate()

	const [username, setUsername] = useState('');
	const userImage = localStorage.getItem('userImage');
	const [isLoggedIn, setIsLoggedIn] = useState(false);

	useEffect(() => {
		const storedUsername = localStorage.getItem('username')
		if (storedUsername) {
			setUsername(storedUsername)
			setIsLoggedIn(true)
		}	
	}, [])

	const handleLogout = async () => {
		try {
			const response = await axios.post(
				`${api_url}/logout`,
				{},
				{
					headers: {
						'Content-Type': 'application/json'
					}
				}
			)

			if (response.status === 200) {
				localStorage.removeItem('username')
				setIsLoggedIn(false)
				navigate('/login')
			}
		} catch (err) {
			console.error(err)
		}
	}

	const SidebarData = [
		{
			label: isLoggedIn ? 'My Profile' : 'Login',
			icon: <IoIcons.IoIosCreate />,
			action: isLoggedIn ? undefined : () => navigate('/login')
		},
		{
			label: 'Account Settings',
			icon: 'pi pi-fw pi-home'
		},
		{
			label: 'Homepage',
			icon: 'pi pi-fw pi-home'
		},
		{
			label: 'Forum',
			icon: 'pi pi-fw pi-home'
		},
		{
			label: 'Groups',
			icon: 'pi pi-fw pi-info'
		},
		{
			label: 'Games',
			icon: 'pi pi-fw pi-info'
		},
		isLoggedIn && {
			label: 'Logout',
			icon: 'pi pi-fw pi-home',
			action: handleLogout
		}
	].filter(Boolean)

	return (
		<div>
			<Topbar />
			<nav className='sidebar'>
				<div style={{ width: '100%' }}>
					<div style={{ display: 'grid', justifyContent: 'center', margin: '20px' }}>
						{userImage && <img src={`data:image/png;base64,${userImage}`} alt="Profile"
							style={{ width: '100px', height: '100px', borderRadius: '50%' }}
						/>}
						<div
							style={{
								display: 'flex',
								justifyContent: 'center',
								alignItems: 'center',
								// color: '#4169E1',
								fontSize: '20px'
							}}
						>
							{username}
						</div>
					</div>
					{SidebarData.map((item, key) => {
						return <SubMenu item={item} key={key} />
					})}
				</div>
			</nav>
		</div>
	)
}

export default Sidebar
