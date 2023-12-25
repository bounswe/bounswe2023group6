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
	Avatar,
	Button
} from '@nextui-org/react'
import { SearchIcon } from '../../SearchIcon.js'
import './Navbar.css'
import { useState, useEffect } from 'react'
import axios from 'axios'
import { useNavigate } from 'react-router-dom'
import logo from '../../gamelounge.png'
import { getAllSearch } from '../../services/searchService.js'
import {getUserInfoBySessionId} from "../../services/userService";
const Navbarx = () => {
	const api_url = process.env.REACT_APP_API_URL
	const navigate = useNavigate()

	const [username, setUsername] = useState('')
	const userImage = localStorage.getItem('userImage')
	const [isLoggedIn, setIsLoggedIn] = useState(false)
	const [isAdmin, setIsAdmin] = useState(false)
	const [currentUser, setCurrentUser] = useState(null);

	const navigateToLogin = () => {
		navigate('/login')
	}
	const navigateToSignup = () => {
		navigate('/signup')
	}
	useEffect(() => {
		const storedUsername = localStorage.getItem('username')
		if (storedUsername) {
			setUsername(storedUsername)
			setIsLoggedIn(true)
		} else {
			setIsLoggedIn(false)
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
				setIsLoggedIn(false)
				localStorage.removeItem('username')
				localStorage.removeItem('isAdmin')
				navigate('/home')
				window.location.reload();
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

	useEffect(() => {
		const isAdmin = JSON.parse(localStorage.getItem('isAdmin'))
		if (isAdmin) {
		  setIsAdmin(true)
		}
	}, [])
	const [searchResults, setSearchResults] = useState([])
	const [searchQuery, setSearchQuery] = useState('')
	const navigateToSearch = (result) => {
		// Use the 'navigate' function from 'react-router-dom' to navigate to the Search component
		navigate('/search', { state: { searchData: result } })
	}
	const handleSearch = async () => {
		try {
			const response = await getAllSearch(searchQuery)

			if (response.status === 200) {
				setSearchResults(response.data)
				console.log(searchResults)
				navigateToSearch(response.data)
			}
		} catch (error) {
			console.error(error)
		}
	}

	const handleInputChange = (e) => {
		setSearchQuery(e.target.value)
		// Trigger search when the user stops typing for 300 milliseconds
	}

	  useEffect(() => {
              const fetchUserInfo = async () => {
                  try {
                      const response = await getUserInfoBySessionId();
                      const userData = response.data;
                      setCurrentUser(userData);
                      console.log('Current User:', userData);
                  } catch (error) {
                      console.error('Error fetching user info:', error);
                  }
              };
              fetchUserInfo();
          }, []);

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
						<Link href='/groups' aria-current='page' className='text-[#fff4e0]'>
							Groups
						</Link>
					</NavbarItem>
					{isAdmin && (
						<NavbarItem>
							<Link href='/admin-panel' aria-current='page' className='text-[#fff4e0]'>
							Admin Panel
							</Link>
						</NavbarItem>
					)}
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
					onChange={handleInputChange}
					onKeyDown={(e) => {
						if (e.key === 'Enter') {
							handleSearch()
						}
					}}
				/>
				{isLoggedIn ? (
					<Dropdown placement='bottom-end' justify='end'>
						<DropdownTrigger>
							<Avatar
								isBordered
								as='button'
								className='transition-transform'
								color='default'
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
										onKeyDown={(e) => {
											if (e.key === 'Enter') {
												handleSearch()
											}
										}}
									/>
								</DropdownItem>
							) : null}

							<DropdownItem key='settings' closeOnSelect='false' onClick={() => navigate(`/users/${currentUser.username}`)}>
								My Profile
							</DropdownItem>
							<DropdownItem key='team_settings'>Account Settings</DropdownItem>
							<DropdownItem key='logout' color='danger' onClick={handleLogout}>
								Log Out
							</DropdownItem>
						</DropdownMenu>
					</Dropdown>
				) : windowWidth < 768 ? (
					<Button color='default' variant='faded' size='md' onClick={navigateToLogin}>
						Log In
					</Button>
				) : (
					<div className='flex'>
						<Button color='default' variant='faded' size='md' onClick={navigateToLogin}>
							Log In
						</Button>
						<Button color='default' variant='faded' size='md' style={{ marginLeft: 12 }} onClick={navigateToSignup}>
							Sign Up
						</Button>
					</div>
				)}
			</NavbarContent>
		</Navbar>
	)
}
export default Navbarx
