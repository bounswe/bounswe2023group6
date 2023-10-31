import React from 'react'
import { Link } from 'react-router-dom'
import styled from 'styled-components'
import { Button } from 'primereact/button'

const SidebarLink = styled(Link)`
	display: flex;
	color: black;
	justify-content: space-between;
	align-items: center;
	padding: 20px;
	list-style: none;
	height: 60px;
	text-decoration: none;
	&:hover {
		background-color: rgba(0, 0, 0, 0.1);
		cursor: pointer;
	}
`

const SubMenu = ({ item }) => {
	return (
		<>
			<div onClick={item.action}>
				<SidebarLink to={item.path} className='submenu'>
					<Button
						style={{
							width: '260px',
							backgroundColor: '#FFBF9B',
							color: '#4D4D4D',
							border: 'none',
							justifyContent: 'center',
							height: '40px'
						}}
					>
						{item.label}
					</Button>
				</SidebarLink>
			</div>
		</>
	)
}

export default SubMenu
