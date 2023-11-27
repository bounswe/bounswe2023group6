import React from 'react'
import {
	Navbar,
	NavbarBrand,
	NavbarContent,
	NavbarItem,
	Link,
	Input,
	DropdownItem,
	DropdownTrigger,
	Dropdown,
	DropdownMenu,
	Avatar
} from '@nextui-org/react'
import { SearchIcon } from '../../SearchIcon.js'
import './Navbar.css'
import { useState, useEffect } from 'react'
import axios from 'axios'
import { useNavigate } from 'react-router-dom'
import logo from '../../gamelounge.png'
const Navbarx = () => {
	const api_url = process.env.REACT_APP_API_URL
	const navigate = useNavigate()

	const [username, setUsername] = useState('')
	const userImage = localStorage.getItem('userImage')

	useEffect(() => {
		const storedUsername = localStorage.getItem('username')
		if (storedUsername) {
			setUsername(storedUsername)
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
					},
					withCredentials: true
				}
			)

			if (response.status === 200) {
				localStorage.removeItem('username')
				navigate('/login')
			}
		} catch (err) {
			console.error(err)
		}
	}
	const handleInputClick = (e) => {
		// Prevent the click event from propagating to the dropdown
		e.stopPropagation()
		// Focus on the input field
		const input = e.currentTarget.querySelector('input')
		if (input) {
			input.focus()
		}
	}
	const [windowWidth, setWindowWidth] = useState(window.innerWidth)
	useEffect(() => {
		const handleResize = () => {
			setWindowWidth(window.innerWidth)
		}

		window.addEventListener('resize', handleResize)

		return () => {
			window.removeEventListener('resize', handleResize)
		}
	}, [])

	return (
		<Navbar isBordered className='bg-black'>
			<NavbarContent justify='start'>
				<NavbarBrand className='mr-4'>
					<img src={logo} className='rounded-lg' height='48' width='64' />
				</NavbarBrand>
				<NavbarContent className='smx:flex gap-3'>
					<NavbarItem>
						<Link href='/home' className='text-[#fff4e0]'>
							Home
						</Link>
					</NavbarItem>
					<NavbarItem>
						<Link href='/game' aria-current='page' className='text-[#fff4e0]'>
							Game
						</Link>
					</NavbarItem>
					<NavbarItem>
						<Link href='/forum' aria-current='page' className='text-[#fff4e0]'>
							Forum
						</Link>
					</NavbarItem>
					<NavbarItem>
						<Link href='#' className='text-[#fff4e0]'>
							Groups
						</Link>
					</NavbarItem>
				</NavbarContent>
			</NavbarContent>
			<NavbarContent as='div' className=' items-center  ' justify='end'>
				<Input
					classNames={{
						base: 'max-w-full smx:hidden h-10',
						mainWrapper: ' h-full smx:hidden',
						input: ' text-small smx:hidden',
						inputWrapper: 'smx:hidden h-full font-normal text-default-500 bg-default-400/20 dark:bg-default-500/20'
					}}
					placeholder='Type to search...'
					size='sm'
					startContent={<SearchIcon size={18} />}
					type='search'
				/>
				<Dropdown placement='bottom-end' justify='end'>
					<DropdownTrigger>
						<Avatar
							isBordered
							as='button'
							className='transition-transform'
							color='secondary'
							name='Jason Hughes'
							size='sm'
							src={userImage}
						></Avatar>
					</DropdownTrigger>
					<DropdownMenu aria-label='Profile Actions' variant='flat' closeOnSelect={false}>
						<DropdownItem key='profile' className='h-14 gap-2'>
							<p className='font-semibold'>Signed in as </p>
							<p className='font-semibold'>{username}</p>
						</DropdownItem>
						{windowWidth < 768 ? (
							<DropdownItem key='search' onClick={handleInputClick}>
								<Input
									classNames={{
										base: 'max-w-full nsm:hidden h-10',
										mainWrapper: 'nsm:hidden h-full',
										input: 'nsm:hidden text-small',
										inputWrapper:
											'nsm:hidden h-full font-normal text-default-500 bg-default-400/20 dark:bg-default-500/20'
									}}
									placeholder='Type to search...'
									size='sm'
									startContent={<SearchIcon size={18} />}
									type='search'
								/>
							</DropdownItem>
						) : null}

						<DropdownItem key='settings' closeOnSelect='false' onClick={() => navigate('/profile-page')}>
							My Profile
						</DropdownItem>
						<DropdownItem key='team_settings'>Account Settings</DropdownItem>
						<DropdownItem key='logout' color='danger' onClick={handleLogout}>
							Log Out
						</DropdownItem>
					</DropdownMenu>
				</Dropdown>
			</NavbarContent>
		</Navbar>
	)
}
export default Navbarx
