# 🎯 Admin & Client Dashboards - Complete Guide

## Overview

Your proposal system now has **two separate interfaces**:

1. **Admin Dashboard** - Full control and customization
2. **Client Dashboard** - Professional read-only view

---

## 🛠️ Admin Dashboard

### Access
`http://localhost:3000/admin/proposals`

### Features

#### 1. **General Info Tab**
- **Client Information**
  - Client Name
  - Client Email
  - Project Title
  - Project Description
  - Valid Until Date
  - Additional Notes

- **Your Company**
  - Company Name
  - Company Email

- **Terms & Conditions**
  - Deposit Required (%)
  - Timeline
  - Additional Terms

#### 2. **Services Tab**
- **View All Services** on the left
- **Add New Services** with "+ Add" button
- **Edit Each Service**:
  - Item Name ✏️
  - Description ✏️
  - Price (with quantity) ✏️
  - Currency (USD, EUR, GBP, INR, CAD, AUD) ✏️
  - Category ✏️
  - Delete option for custom items

- **Real-time Total** shows selected items price

#### 3. **Preview Tab**
- See how the proposal looks to clients
- Print/PDF download ready

### Auto-Save Feature
✅ All changes save automatically to browser localStorage  
✅ Your work is never lost  
✅ Persists across browser sessions

### Export Options
- **Export JSON** - Download proposal as JSON file (backup/share)
- **New Proposal** - Start fresh with template

### Editing an Item
1. Find the service in the left panel
2. Click "Edit" button
3. Modify all fields:
   - Name
   - Description
   - Price
   - Currency
   - Quantity
   - Subtotal (auto-calculated)
4. Click "Save"

---

## 👁️ Client Dashboard

### Access
Clients now receive proposals via **email** with embedded links or attachments.

### View
- **Professional proposal template** (same as admin preview)
- **Read-only** - No editing possible
- Details shown:
  - Client name & email
  - Project title & description
  - All selected services & pricing
  - Company details
  - Terms & conditions
  - Notes

### Client Actions
- **Print / Save as PDF** - Print directly from browser
- **Accept Proposal** - Mark as accepted
- **Decline Proposal** - Mark as declined

### What Clients See
✅ Professional formatted proposal  
✅ Clear itemization with prices  
✅ Total with breakdown  
✅ All terms and conditions  
✅ Company contact information  

❌ Cannot edit anything  
❌ Cannot see admin interface  

---

## 📊 Data Structure

### Proposal Object
```typescript
{
  id: string,                    // Unique proposal ID
  clientName: string,
  clientEmail?: string,
  projectTitle: string,
  projectDescription?: string,
  selectedItems: string[],       // Array of item IDs
  items: ProposalItem[],
  notes?: string,
  validUntil?: string,
  terms?: {
    depositPercent?: number,
    timeline?: string,
    additionalTerms?: string
  },
  companyName?: string,
  companyEmail?: string,
  createdAt?: string,
  updatedAt?: string
}
```

### ProposalItem Object
```typescript
{
  id: string,
  name: string,
  description: string,
  price: number,
  currency?: string,            // USD, EUR, GBP, INR, CAD, AUD
  category?: string,            // Design, Development, Marketing, Support, Custom
  quantity?: number             // For bulk items
}
```

---

## 💾 Storage & Backup

### LocalStorage
- All proposals automatically save to browser localStorage
- Key: `currentProposal`
- Data persists across sessions

### Exporting Proposals
1. Go to Admin Dashboard
2. Click "⬇️ Export JSON"
3. This downloads your entire proposal as a JSON file
4. Save it as backup or share it

### Importing Proposals
To load a saved proposal:
```javascript
// In browser console:
localStorage.setItem('currentProposal', JSON.stringify(yourProposalData))
```

---

## 🎨 Customization Guide

### Add New Default Services
Edit `/app/lib/proposalTypes.ts`:
```typescript
export const DEFAULT_ITEMS: ProposalItem[] = [
  {
    id: "your-service-id",
    name: "Service Name",
    description: "Service Description",
    price: 5000,
    currency: "USD",
    category: "Your Category",
    quantity: 1,
  },
  // ... more items
];
```

### Edit Default Terms
Edit `/app/lib/proposalTypes.ts`:
```typescript
export const DEFAULT_TERMS: ProposalTerms = {
  depositPercent: 50,
  timeline: "Your timeline here",
  additionalTerms: "Additional terms here",
};
```

### Change Currency Options
Edit `ItemEditor.tsx` select dropdown:
```tsx
<select value={editedItem.currency || 'USD'} ...>
  <option value="USD">USD</option>
  <option value="YOUR_CURRENCY">Your Currency</option>
</select>
```

---

## 🔄 Workflow Example

### Creating a Proposal

1. **Go to Admin Dashboard**
   - `http://localhost:3000/admin/proposals`

2. **Enter Client Info**
   - Client Name: "Acme Corp"
   - Client Email: "contact@acmecorp.com"
   - Project Title: "Website Redesign"
   - Project Description: "Modern, responsive website"
   - Valid Until: Select a date

3. **Select Services**
   - Check boxes in Services tab
   - Example: Web Design + Web Development + Maintenance

4. **Customize Each Service**
   - Click "Edit" on Web Development
   - Change price to $5000
   - Change quantity to 1
   - Add specific details in description
   - Click "Save"

5. **Add Custom Item** (if needed)
   - Click "+ Add" button
   - Fill in name, description, price
   - Click "Add"

6. **Edit Terms**
   - Set deposit to 50%
   - Add timeline info
   - Add any special terms

7. **Add Notes**
   - Include project timeline
   - Special conditions
   - Payment methods

8. **Preview**
   - Click "Preview" tab
   - Review how it looks

9. **Share with Client**
   - Send proposals via **email** (configured in email service)
   - They see the proposal in read-only format

10. **Client Actions**
    - Client can print as PDF
    - Client can accept/decline
    - You'll get notification

---

## 💡 Tips & Best Practices

### Pricing Strategy
- Keep base prices in services
- Use quantity for bulk services
- Multiple currencies supported

### Professional Look
- Clear, descriptive service names
- Detailed descriptions help clients understand value
- Include timeline in notes
- Be specific with payment terms

### Client Communication
- Add client email so they know it's personalized
- Include your company email
- Add relevant notes about timeline
- Be transparent with terms

### Service Categories
Use these for organization:
- **Design** - UI/UX, Graphics
- **Development** - Frontend, Backend, Full-stack
- **Marketing** - SEO, Content, Ads
- **Support** - Maintenance, Hosting
- **Custom** - Your own categories

---

## 🔧 Advanced Features

### Multiple Currencies per Item
Each item can have different currency:
- Item 1: USD $5000
- Item 2: EUR €4500
- Item 3: INR ₹400000

### Quantity-Based Pricing
Great for:
- Hourly consultations (quantity = hours)
- Bulk services
- Volume discounts

Formula: **Price × Quantity = Line Total**

### Custom Items
- Add items on the fly
- Edit/delete anytime
- Not preset in defaults

---

## 📋 Troubleshooting

### My changes aren't saving
✓ Check browser's LocalStorage isn't disabled  
✓ Try refreshing the page  
✓ Check browser console for errors  

### Client not receiving emails
✓ Check email service configuration  
✓ Verify email address is correct  

### PDF print looks weird
✓ Use Chrome or Edge  
✓ Adjust margins in print dialog  
✓ Try "A4" paper size  

### Export not working
✓ Check popup blocker isn't preventing download  
✓ Ensure proposal has at least one field  

---

## 🚀 Next Steps

1. Create your first proposal in Admin Dashboard
2. Go to Client Dashboard to see how it looks
3. Print as PDF
4. Export as JSON for backup
5. Customize services for your business

---

## 📞 Support

For issues or questions:
- Check console for error messages (F12)
- Verify all required fields are filled
- Try refreshing the page
- Clear browser cache if needed

Happy proposing! 📝
