import React from 'react'
import Suggestion from './Suggestion';
import Post from './Post';
import Group from './Group';
import Sidebar from '../../components/Sidebar'

export default function HomePage() {

    const groupData = [
        {
            image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
            header: '"Looking for a co-op adventure in Hyrule!"',
            text: "Need a skilled squad for high-intensity chicken dinners! Who's in for some PUBG action? Let's conquer the battleground together! 🍗🔫",
            players: '4/5'
        },
        {
            image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
            header: '"Searching for squadmates for some intense battle royale action!"',
            text: "Building forts and taking names! Searching for fellow Fortnite warriors to join my squad. Let's get those Victory Royales! 🏰👑",
            players: '4/5'
        },
        {
            image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
            header: 'Anyone for Rocket league',
            text: "Ready to score some goals and pull off epic aerials? Looking for Rocket League teammates who can bring the heat on the field. Let's drive to victory! 🚗⚽",
            players: '4/5'
        },
    ];

    const suggestionData = [
        {
            image: `https://primefaces.org/cdn/primereact/images/product/bamboo-watch.jpg}`,
            username: 'Kerim Bahadır',
            tag: '#counterstrike #developer',
        },
        {
            image: `https://primefaces.org/cdn/primereact/images/product/brown-purse.jpg}`,
            username: 'Ali Kasap',
            tag: '#counterstrike #gamer #rpg',
        },
        {
            image: `https://primefaces.org/cdn/primereact/images/product/galaxy-earrings.jpg}`,
            username: 'Zehra Yıldırım',
            tag: '#counterstrike .#dota2',
        },
        {
            image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
            username: 'Mahmut Demir',
            tag: '#counterstrike #fighter',
        }
    ];

    const postData = [
        {
            image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
            header: 'Resident Evil 4 Remake',
            content: "Looking for someone to join me in my Resident Evil 4 adventure! Let's team up and face the horrors together.️ #ResidentEvil4 #GamingBuddyWanted",
            date: '29.10.2023  00.00',
        },
        {
            image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
            header: 'Fallout 4: Post-Apocalyptic Adventure',
            content: "world exploration are immersive. The character customization adds depth, and the game's atmosphere and details are impressive. What are your thoughts on the game? Enjoy!",
            date: '29.10.2023  00.00',
        },
        {
            image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
            header: 'The Witcher 3: Wild Hunt',
            content: "The Witcher 3 is an unforgettable gaming experience. Its open world, rich storytelling, and captivating characters make it a must-play RPG. If you love epic adventures, this one's a masterpiece.",
            date: '29.10.2023  00.00',
        },
    ];



    return (
        <div style={{margin: '20px', overflowY: 'hidden', padding: '10px'}} id="app-container">
            <Sidebar/>
            <div>
                <div className='suggestions'>
                    {suggestionData.map((item, key) => {
                        return <Suggestion item={item} key={key}/>;
                    })}
                </div>
                <div className='container'>
                    <div className='posts'>
                        {postData.map((item, key) => {
                            return <Post item={item} key={key}/>;
                        })}
                    </div>
                    <div className='posts'>
                        {groupData.map((item, key) => {
                            return <Group item={item} key={key}/>;

                        })}
                    </div>
                </div>
            </div>
        </div>
    )
}
