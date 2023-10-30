import React from 'react';
import SubMenu from './SubMenu';
import * as IoIcons from 'react-icons/io';
import Topbar from './Topbar';

const Sidebar = () => {
    const SidebarData = [
        {
            label: 'My Profile',
            icon: <IoIcons.IoIosCreate  />,
        },
        {
            label: 'Account Settings',
            icon: 'pi pi-fw pi-home',
        },
        {
            label: 'Log out',
            icon: 'pi pi-fw pi-home',
        },
        {
            label: 'Homepage',
            icon: 'pi pi-fw pi-home',
        },
        {
            label: 'Forum',
            icon: 'pi pi-fw pi-home',
        },
        {
            label: 'Groups',
            icon: 'pi pi-fw pi-info',
        },
    ];

    return (
        <div>
                <Topbar/>
                <nav className='sidebar'>
                    <div style={{width: '100%'}}>
                        <div style={{display: 'grid', justifyContent: 'center', margin: '20px'}}>
                            <img src={`https://primefaces.org/cdn/primereact/images/product/bamboo-watch.jpg}`} alt={"Ayşe Çağlayan"} style={{width: '100px', height: '100px', borderRadius:'50%'}} />
                        </div>
                        {SidebarData.map((item, key) => {
                            return <SubMenu item={item} key={key} />;

                        })}
                    </div>
                </nav>
        </div>

    );
};

export default Sidebar;
