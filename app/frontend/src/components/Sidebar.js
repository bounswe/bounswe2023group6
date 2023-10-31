import React from 'react'
import SubMenu from './SubMenu'
import * as IoIcons from 'react-icons/io'
import Topbar from './Topbar'
import axios from 'axios';
import { useNavigate } from 'react-router-dom'

const Sidebar = () => {
	const navigate = useNavigate();

	const handleLogout = async () => {
		try {
		const response = await axios.post('http://167.99.242.175:8080/logout', {}, {
			headers: {
			'Content-Type': 'application/json'
			}
		});

		if (response.status === 200) {
			navigate('/login'); // Redirect to login page
		}
		} catch (err) {
		console.error(err);
		}
	};

	const SidebarData = [
		{
			label: 'My Profile',
			icon: <IoIcons.IoIosCreate />
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
			label: 'Logout',
			icon: 'pi pi-fw pi-home',
			action: handleLogout
		},
	]

	return (
		<div>
			<Topbar />
			<nav className='sidebar'>
				<div style={{ width: '100%' }}>
					<div style={{ display: 'grid', justifyContent: 'center', margin: '20px' }}>
						<img
							src={`https://primefaces.org/cdn/primereact/images/product/bamboo-watch.jpg}`}
							alt={'Ayşe Çağlayan'}
							style={{ width: '100px', height: '100px', borderRadius: '50%' }}
						/>
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
