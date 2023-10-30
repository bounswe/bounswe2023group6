import { InputText } from "primereact/inputtext";

const Topbar = () => {
    return (
        <div className="top-bar" >
            <span className="p-input-icon-right">
                <i className="pi pi-search" />
                <InputText placeholder="Search"/>
            </span>
        </div>
    );
}

export default Topbar;