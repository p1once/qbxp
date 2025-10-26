const date = new Date();

const app = new Vue({
    el: '#tablet',
    data: {
        opened: false,
        currentPage: 'main',
        Calendar: {
            day: date.toLocaleDateString('en-US', { 
                weekday: 'long' 
            }),
            date: date.getDate()
        },
        Crypto: [
            { name: 'Bitcoin', icon: 'img/btc.svg', description: 'Your gateway to Bitcoin & beyond' }, 
            { name: 'Ethereum', icon: 'img/eth.svg', description: 'The tech is new and ever-evolving' }, 
            { name: 'Avalanche', icon: 'img/avax.svg', description: 'Blazingly Fast, Low Cost & Eco-Friendly' }
        ],
        Applications: [
            { name: 'Biens', icon: 'img/info.svg', href: 'properties' }, 
            { name: 'Opérations', icon: 'img/controls.svg', href: 'Opérations' },
            { name: 'Contrats', icon: 'img/info.svg', href: 'contracts' }
        ],
        // listing state
        List: { items: [], total: 0, limit: 25, offset: 0 },
        Filters: { query: '', status: 'all', sort: 'id', order: 'ASC', minPrice: '', maxPrice: '', rentOnly: false },
        Selected: null,
        // forms
        SearchId: '',
        UpdateForm: { id: '', name: '', price: '', rent_interval: '' },
        TransferForm: { id: '', target: '' },
        Contract: { id: '', target: '' },
        EvictId: '',
        Visit: { id: '', target: '' },
        NameList: { items: [], selected: '' },
        RowMenu: null
    },
    mounted() {
        let initial = document.getElementById(this.currentPage);
        initial.style.opacity = 1;
        this.loadNameList();
    },
    methods: {
        async post(url, data = {}) {
            const response = await fetch(`https://${GetParentResourceName()}/${url}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });
            
            return await response.json();
        },
        setPageOpacity(id, value) {
            let page = document.getElementById(id);
            page.style.opacity = value;
        },
        async switchPage(page) {
            if (this.currentPage == page) return;

            this.setPageOpacity(this.currentPage, 0);
            this.currentPage = page;

            setTimeout(() => {
                this.setPageOpacity(page, 1);
            }, 50);
            if (page === 'properties') {
                this.refreshList(true);
            }
        },
        async loadNameList() {
            try {
                const res = await this.post('listProperties', { sort: 'name', order: 'ASC', limit: 100, status: 'all' });
                this.NameList.items = (res.items || []).map(it => ({ id: it.id, name: it.property_name }));
            } catch (e) {}
        },
        async refreshList(reset=false) {
            if (reset) this.List.offset = 0;
            const payload = {
                query: this.Filters.query,
                status: this.Filters.status,
                sort: this.Filters.sort,
                order: this.Filters.order,
                minPrice: this.Filters.minPrice || undefined,
                maxPrice: this.Filters.maxPrice || undefined,
                limit: this.List.limit,
                offset: this.List.offset,
                rentOnly: this.Filters.rentOnly,
            };
            const res = await this.post('listProperties', payload);
            this.List.items = res.items || [];
            this.List.total = res.total || 0;
        },
        toggleRowMenu(id) { this.RowMenu = (this.RowMenu === id) ? null : id; },
        manageRow(it) { this.RowMenu = null; this.Selected = it; this.UpdateForm.id = it.id; this.UpdateForm.name = it.property_name; this.UpdateForm.price = it.price; this.UpdateForm.rent_interval = it.rent_interval || ''; this.TransferForm.id = it.id; },
        async garageHereRow(it) { this.RowMenu = null; await this.post('setGarageHere', { id: it.id }); },
        async deleteRow(it) { this.RowMenu = null; if (!confirm('Supprimer ce bien ?')) return; await this.post('deleteProperty', { id: it.id }); this.refreshList(true); },
        async openById() {
            if (!this.SearchId) return;
            const prop = await this.post('getProperty', { id: parseInt(this.SearchId) });
            this.Selected = prop || null;
            if (prop) {
                this.UpdateForm.id = prop.id;
                this.UpdateForm.name = prop.property_name;
                this.UpdateForm.price = prop.price;
                this.UpdateForm.rent_interval = prop.rent_interval || '';
                this.TransferForm.id = prop.id;
            }
        },
        async updateProperty() {
            const payload = {
                id: parseInt(this.UpdateForm.id),
                property_name: this.UpdateForm.name,
                price: this.UpdateForm.price,
                rent_interval: this.UpdateForm.rent_interval === '' ? '' : parseInt(this.UpdateForm.rent_interval)
            };
            const res = await this.post('updateProperty', payload);
            return res;
        },
        closeManage() {
            this.Selected = null;
            this.UpdateForm = { id: '', name: '', price: '', rent_interval: '' };
            this.TransferForm = { id: '', target: '' };
        },
        
        async openBySelectedName() {
            if (!this.NameList.selected) return;
            const id = parseInt(this.NameList.selected);
            if (!id) return;
            const prop = await this.post('getProperty', { id });
            this.Selected = prop || null;
            if (prop) {
                this.UpdateForm.id = prop.id;
                this.UpdateForm.name = prop.property_name;
                this.UpdateForm.price = prop.price;
                this.UpdateForm.rent_interval = prop.rent_interval || '';
                this.switchPage('properties');
            }
        },
        async setGarageHere() {
            if (!this.Selected) return;
            await this.post('setGarageHere', { id: this.Selected.id });
        },
        async deleteSelected() {
            if (!this.Selected) return;
            await this.post('deleteProperty', { id: this.Selected.id });
            this.Selected = null;
            this.refreshList();
        },
        async transferTitle() {
            if (!this.TransferForm.id || !this.TransferForm.target) return;
            await this.post('transferOwnership', { id: parseInt(this.TransferForm.id), target: this.TransferForm.target });
        },
        async createProperty() {
            await this.post('createProperty', {});
        },
        async rentTo() {
            if (!this.Contract.id || !this.Contract.target) return;
            await this.post('rentPropertyTo', { id: parseInt(this.Contract.id), target: this.Contract.target });
        },
        async buyTo() {
            if (!this.Contract.id || !this.Contract.target) return;
            await this.post('buyPropertyTo', { id: parseInt(this.Contract.id), target: this.Contract.target });
        },
        async evict() {
            if (!this.EvictId) return;
            await this.post('evict', { id: parseInt(this.EvictId) });
        },
        async startVisit() {
            if (!this.Visit.id) return;
            await this.post('startVisit', { id: parseInt(this.Visit.id), target: this.Visit.target || '' });
        }
    }
});

window.addEventListener('message', async ({ data }) => {
    switch(data.action) {
        case 'open':
            app.opened = true;
            break;
        case 'close':
            app.opened = false;
            break;
    }
});

window.addEventListener('keydown', async ({ key }) => {
    let which = key.toLowerCase();

    if (which == 'escape')
        return await app.post('close');
});











