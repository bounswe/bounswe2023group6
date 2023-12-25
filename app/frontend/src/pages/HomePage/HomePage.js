import Suggestion from './Suggestion'
import Game from './Game'
import Group from './Group'
import Post from './Post'
import Navbarx from '../../components/navbar/Navbar'
import { getAllGames, getRecommendedGames } from '../../services/gameService'
import { getAllPosts, getRecommendedPosts } from '../../services/postService'
import React, { useEffect, useState } from 'react'

import kerimbahadir from './kerimbahadir.jpg'
import zehrayildirim from './zehrayildirim.jpg'
import mahmutdemir from './mahmutdemir.jpg'
import alikasap from './alikasap.jpg'
import { getRecommendedGroups, getAllGroups } from '../../services/lfgService'

export default function HomePage() {
	const [gamesData, setGamesData] = useState([]);
	const [postData, setPostData] = useState([]);
	const [groupData, setGroupData] = useState([]);

	useEffect(() => {
		const fetchGames = async () => {
			try {
				const response = await getRecommendedGames()
				if (response.data.length != 0) {
					setGamesData(response.data)
				} else {
					const allgames = await getAllGames()
					setGamesData(allgames.data)
				}
			} catch (error) {
				console.log(error)
			}
		}

		fetchGames()
	}, [])

	useEffect(() => {
		const fetchPosts = async () => {
			const response = await getRecommendedPosts()
			if (response.data.length != 0) {
				setPostData(response.data)
			} else {
				const allposts = await getAllPosts()
				setPostData(allposts.data)
			}
		}

		fetchPosts()
	}, [])
	useEffect(() => {
		const fetchGroups = async () => {
			const response = await getRecommendedGroups()
			if (response.data.length != 0) {
				setGroupData(response.data)
			} else {
				const allgroups = await getAllGroups()
				setGroupData(allgroups.data)
			}
		}

		fetchGroups()
	}, [])

	const suggestionData = [
		{
			image: kerimbahadir,
			username: 'Kerim Bahadır',
			tag: '#counterstrike #developer'
		},
		{
			image: alikasap,
			username: 'Ali Kasap',
			tag: '#counterstrike #gamer #rpg'
		},
		{
			image: zehrayildirim,
			username: 'Zehra Yıldırım',
			tag: '#counterstrike #dota2'
		},
		{
			image: mahmutdemir,
			username: 'Mahmut Demir',
			tag: '#counterstrike #fighter'
		}
	]

	console.log(postData)

	return (
		<>
			<Navbarx></Navbarx>
			<div className='flex flex-row grow bg-neutral-100 justify-center items-center'>
				{/* Make elements flex, these will be in a row */}
				{/* <div className='w-1/5 flex flex-col gap-4'> */}
				{/* Take 1/5 width of the screen, flex elements in a column, add gap between elements */}
				{/* </div> */}
				<div className='flex flex-col gap-4 ml-12 mr-12'>
					{/* Take 4/5 width of the screen, flex elements in a column, add gap between elements */}
					<div className='flex w-full items-center justify-center mt-6'>
						<h1>
							<b>Suggestions</b>
						</h1>
					</div>
					<div className='flex w-full justify-center'>
						{/* In the full width you can take (i.e. 4/5), flex elements in a row, center them */}

						{suggestionData.map((item, key) => (
							<Suggestion item={item} key={key} />
						))}
					</div>
					<div className='flex flex-row mx-4'>
						{/* Flex elements in a row, add margin on the left and right */}
						<div className='flex flex-col w-1/3 ml-12 mr-12 pb-8'>
							<div className='flex w-full items-center justify-center mt-4'>
								<h1>
									<b>Games</b>
								</h1>
							</div>
							{/* Take 1/2 width of the screen, flex elements in a column, add margin on the left and right */}
							<div>
								{gamesData
									.filter((game) => game.status === 'APPROVED')
									.map((game) => (
										<Game key={game.gameId} game={game} />
									))}
							</div>
						</div>
						<div className='flex flex-col w-1/3 ml-12 mr-12 pb-8'>
							<div className='flex w-full items-center justify-center mt-4'>
								<h1>
									<b>Groups</b>
								</h1>
							</div>
							{/* Take 1/2 width of the screen, flex elements in a column, add margin on the left and right */}
							{groupData.map((item, key) => (
								<Group item={item} key={key} />
							))}
						</div>

						<div className='flex flex-col w-1/3 ml-12 mr-12 pb-8'>
							<div className='flex w-full items-center justify-center mt-4'>
								<h1>
									<b>Posts</b>
								</h1>
							</div>
							{postData.map((post) => (
								<Post key={post.postId} post={post} />
							))}
						</div>
					</div>
				</div>
			</div>
			<div className='bg-black text-white text-center p-8'>
				<p className='text-m'>@2023 Game Lounge, All rights reserved.</p>
			</div>
		</>
	)
}
