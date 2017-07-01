﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Fincific17.Data
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="finDev4")]
	public partial class FinancificDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void InsertAspNetUser(AspNetUser instance);
    partial void UpdateAspNetUser(AspNetUser instance);
    partial void DeleteAspNetUser(AspNetUser instance);
    partial void InsertProfile(Profile instance);
    partial void UpdateProfile(Profile instance);
    partial void DeleteProfile(Profile instance);
    partial void InsertGlAccount(GlAccount instance);
    partial void UpdateGlAccount(GlAccount instance);
    partial void DeleteGlAccount(GlAccount instance);
    partial void InsertGlAccountDetail(GlAccountDetail instance);
    partial void UpdateGlAccountDetail(GlAccountDetail instance);
    partial void DeleteGlAccountDetail(GlAccountDetail instance);
    partial void InsertSmPeriodConversion(SmPeriodConversion instance);
    partial void UpdateSmPeriodConversion(SmPeriodConversion instance);
    partial void DeleteSmPeriodConversion(SmPeriodConversion instance);
    #endregion
		
		public FinancificDataContext() : 
				base(global::System.Configuration.ConfigurationManager.ConnectionStrings["finDev4ConnectionString"].ConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public FinancificDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public FinancificDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public FinancificDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public FinancificDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<AspNetUser> AspNetUsers
		{
			get
			{
				return this.GetTable<AspNetUser>();
			}
		}
		
		public System.Data.Linq.Table<Profile> Profiles
		{
			get
			{
				return this.GetTable<Profile>();
			}
		}
		
		public System.Data.Linq.Table<GlAccount> GlAccounts
		{
			get
			{
				return this.GetTable<GlAccount>();
			}
		}
		
		public System.Data.Linq.Table<GlAccountDetail> GlAccountDetails
		{
			get
			{
				return this.GetTable<GlAccountDetail>();
			}
		}
		
		public System.Data.Linq.Table<SmPeriodConversion> SmPeriodConversions
		{
			get
			{
				return this.GetTable<SmPeriodConversion>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.AspNetUsers")]
	public partial class AspNetUser : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private string _Id;
		
		private string _Email;
		
		private bool _EmailConfirmed;
		
		private string _PasswordHash;
		
		private string _SecurityStamp;
		
		private string _PhoneNumber;
		
		private bool _PhoneNumberConfirmed;
		
		private bool _TwoFactorEnabled;
		
		private System.Nullable<System.DateTime> _LockoutEndDateUtc;
		
		private bool _LockoutEnabled;
		
		private int _AccessFailedCount;
		
		private string _UserName;
		
		private EntitySet<Profile> _Profiles;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIdChanging(string value);
    partial void OnIdChanged();
    partial void OnEmailChanging(string value);
    partial void OnEmailChanged();
    partial void OnEmailConfirmedChanging(bool value);
    partial void OnEmailConfirmedChanged();
    partial void OnPasswordHashChanging(string value);
    partial void OnPasswordHashChanged();
    partial void OnSecurityStampChanging(string value);
    partial void OnSecurityStampChanged();
    partial void OnPhoneNumberChanging(string value);
    partial void OnPhoneNumberChanged();
    partial void OnPhoneNumberConfirmedChanging(bool value);
    partial void OnPhoneNumberConfirmedChanged();
    partial void OnTwoFactorEnabledChanging(bool value);
    partial void OnTwoFactorEnabledChanged();
    partial void OnLockoutEndDateUtcChanging(System.Nullable<System.DateTime> value);
    partial void OnLockoutEndDateUtcChanged();
    partial void OnLockoutEnabledChanging(bool value);
    partial void OnLockoutEnabledChanged();
    partial void OnAccessFailedCountChanging(int value);
    partial void OnAccessFailedCountChanged();
    partial void OnUserNameChanging(string value);
    partial void OnUserNameChanged();
    #endregion
		
		public AspNetUser()
		{
			this._Profiles = new EntitySet<Profile>(new Action<Profile>(this.attach_Profiles), new Action<Profile>(this.detach_Profiles));
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", DbType="NVarChar(128) NOT NULL", CanBeNull=false, IsPrimaryKey=true)]
		public string Id
		{
			get
			{
				return this._Id;
			}
			set
			{
				if ((this._Id != value))
				{
					this.OnIdChanging(value);
					this.SendPropertyChanging();
					this._Id = value;
					this.SendPropertyChanged("Id");
					this.OnIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Email", DbType="NVarChar(256)")]
		public string Email
		{
			get
			{
				return this._Email;
			}
			set
			{
				if ((this._Email != value))
				{
					this.OnEmailChanging(value);
					this.SendPropertyChanging();
					this._Email = value;
					this.SendPropertyChanged("Email");
					this.OnEmailChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_EmailConfirmed", DbType="Bit NOT NULL")]
		public bool EmailConfirmed
		{
			get
			{
				return this._EmailConfirmed;
			}
			set
			{
				if ((this._EmailConfirmed != value))
				{
					this.OnEmailConfirmedChanging(value);
					this.SendPropertyChanging();
					this._EmailConfirmed = value;
					this.SendPropertyChanged("EmailConfirmed");
					this.OnEmailConfirmedChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PasswordHash", DbType="NVarChar(MAX)")]
		public string PasswordHash
		{
			get
			{
				return this._PasswordHash;
			}
			set
			{
				if ((this._PasswordHash != value))
				{
					this.OnPasswordHashChanging(value);
					this.SendPropertyChanging();
					this._PasswordHash = value;
					this.SendPropertyChanged("PasswordHash");
					this.OnPasswordHashChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_SecurityStamp", DbType="NVarChar(MAX)")]
		public string SecurityStamp
		{
			get
			{
				return this._SecurityStamp;
			}
			set
			{
				if ((this._SecurityStamp != value))
				{
					this.OnSecurityStampChanging(value);
					this.SendPropertyChanging();
					this._SecurityStamp = value;
					this.SendPropertyChanged("SecurityStamp");
					this.OnSecurityStampChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PhoneNumber", DbType="NVarChar(MAX)")]
		public string PhoneNumber
		{
			get
			{
				return this._PhoneNumber;
			}
			set
			{
				if ((this._PhoneNumber != value))
				{
					this.OnPhoneNumberChanging(value);
					this.SendPropertyChanging();
					this._PhoneNumber = value;
					this.SendPropertyChanged("PhoneNumber");
					this.OnPhoneNumberChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PhoneNumberConfirmed", DbType="Bit NOT NULL")]
		public bool PhoneNumberConfirmed
		{
			get
			{
				return this._PhoneNumberConfirmed;
			}
			set
			{
				if ((this._PhoneNumberConfirmed != value))
				{
					this.OnPhoneNumberConfirmedChanging(value);
					this.SendPropertyChanging();
					this._PhoneNumberConfirmed = value;
					this.SendPropertyChanged("PhoneNumberConfirmed");
					this.OnPhoneNumberConfirmedChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_TwoFactorEnabled", DbType="Bit NOT NULL")]
		public bool TwoFactorEnabled
		{
			get
			{
				return this._TwoFactorEnabled;
			}
			set
			{
				if ((this._TwoFactorEnabled != value))
				{
					this.OnTwoFactorEnabledChanging(value);
					this.SendPropertyChanging();
					this._TwoFactorEnabled = value;
					this.SendPropertyChanged("TwoFactorEnabled");
					this.OnTwoFactorEnabledChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LockoutEndDateUtc", DbType="DateTime")]
		public System.Nullable<System.DateTime> LockoutEndDateUtc
		{
			get
			{
				return this._LockoutEndDateUtc;
			}
			set
			{
				if ((this._LockoutEndDateUtc != value))
				{
					this.OnLockoutEndDateUtcChanging(value);
					this.SendPropertyChanging();
					this._LockoutEndDateUtc = value;
					this.SendPropertyChanged("LockoutEndDateUtc");
					this.OnLockoutEndDateUtcChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LockoutEnabled", DbType="Bit NOT NULL")]
		public bool LockoutEnabled
		{
			get
			{
				return this._LockoutEnabled;
			}
			set
			{
				if ((this._LockoutEnabled != value))
				{
					this.OnLockoutEnabledChanging(value);
					this.SendPropertyChanging();
					this._LockoutEnabled = value;
					this.SendPropertyChanged("LockoutEnabled");
					this.OnLockoutEnabledChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_AccessFailedCount", DbType="Int NOT NULL")]
		public int AccessFailedCount
		{
			get
			{
				return this._AccessFailedCount;
			}
			set
			{
				if ((this._AccessFailedCount != value))
				{
					this.OnAccessFailedCountChanging(value);
					this.SendPropertyChanging();
					this._AccessFailedCount = value;
					this.SendPropertyChanged("AccessFailedCount");
					this.OnAccessFailedCountChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UserName", DbType="NVarChar(256) NOT NULL", CanBeNull=false)]
		public string UserName
		{
			get
			{
				return this._UserName;
			}
			set
			{
				if ((this._UserName != value))
				{
					this.OnUserNameChanging(value);
					this.SendPropertyChanging();
					this._UserName = value;
					this.SendPropertyChanged("UserName");
					this.OnUserNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="AspNetUser_Profile", Storage="_Profiles", ThisKey="Id", OtherKey="AspNetUserId")]
		public EntitySet<Profile> Profiles
		{
			get
			{
				return this._Profiles;
			}
			set
			{
				this._Profiles.Assign(value);
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
		
		private void attach_Profiles(Profile entity)
		{
			this.SendPropertyChanging();
			entity.AspNetUser = this;
		}
		
		private void detach_Profiles(Profile entity)
		{
			this.SendPropertyChanging();
			entity.AspNetUser = null;
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.Profile")]
	public partial class Profile : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _Id;
		
		private string _AspNetUserId;
		
		private string _FirstName;
		
		private string _LastName;
		
		private string _NickName;
		
		private EntityRef<AspNetUser> _AspNetUser;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIdChanging(int value);
    partial void OnIdChanged();
    partial void OnAspNetUserIdChanging(string value);
    partial void OnAspNetUserIdChanged();
    partial void OnFirstNameChanging(string value);
    partial void OnFirstNameChanged();
    partial void OnLastNameChanging(string value);
    partial void OnLastNameChanged();
    partial void OnNickNameChanging(string value);
    partial void OnNickNameChanged();
    #endregion
		
		public Profile()
		{
			this._AspNetUser = default(EntityRef<AspNetUser>);
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", AutoSync=AutoSync.OnInsert, DbType="Int NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true)]
		public int Id
		{
			get
			{
				return this._Id;
			}
			set
			{
				if ((this._Id != value))
				{
					this.OnIdChanging(value);
					this.SendPropertyChanging();
					this._Id = value;
					this.SendPropertyChanged("Id");
					this.OnIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_AspNetUserId", DbType="NVarChar(128)")]
		public string AspNetUserId
		{
			get
			{
				return this._AspNetUserId;
			}
			set
			{
				if ((this._AspNetUserId != value))
				{
					if (this._AspNetUser.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnAspNetUserIdChanging(value);
					this.SendPropertyChanging();
					this._AspNetUserId = value;
					this.SendPropertyChanged("AspNetUserId");
					this.OnAspNetUserIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FirstName", DbType="NVarChar(144)")]
		public string FirstName
		{
			get
			{
				return this._FirstName;
			}
			set
			{
				if ((this._FirstName != value))
				{
					this.OnFirstNameChanging(value);
					this.SendPropertyChanging();
					this._FirstName = value;
					this.SendPropertyChanged("FirstName");
					this.OnFirstNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastName", DbType="NVarChar(144)")]
		public string LastName
		{
			get
			{
				return this._LastName;
			}
			set
			{
				if ((this._LastName != value))
				{
					this.OnLastNameChanging(value);
					this.SendPropertyChanging();
					this._LastName = value;
					this.SendPropertyChanged("LastName");
					this.OnLastNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_NickName", DbType="NVarChar(144)")]
		public string NickName
		{
			get
			{
				return this._NickName;
			}
			set
			{
				if ((this._NickName != value))
				{
					this.OnNickNameChanging(value);
					this.SendPropertyChanging();
					this._NickName = value;
					this.SendPropertyChanged("NickName");
					this.OnNickNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="AspNetUser_Profile", Storage="_AspNetUser", ThisKey="AspNetUserId", OtherKey="Id", IsForeignKey=true)]
		public AspNetUser AspNetUser
		{
			get
			{
				return this._AspNetUser.Entity;
			}
			set
			{
				AspNetUser previousValue = this._AspNetUser.Entity;
				if (((previousValue != value) 
							|| (this._AspNetUser.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._AspNetUser.Entity = null;
						previousValue.Profiles.Remove(this);
					}
					this._AspNetUser.Entity = value;
					if ((value != null))
					{
						value.Profiles.Add(this);
						this._AspNetUserId = value.Id;
					}
					else
					{
						this._AspNetUserId = default(string);
					}
					this.SendPropertyChanged("AspNetUser");
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.GlAccount")]
	public partial class GlAccount : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _Id;
		
		private string _Number;
		
		private string _Description;
		
		private System.Nullable<int> _AccountTypeId;
		
		private System.Nullable<int> _BalanceTypeId;
		
		private System.Nullable<int> _ConsolidateToAccountId;
		
		private EntitySet<GlAccount> _GlAccounts;
		
		private EntitySet<GlAccountDetail> _GlAccountDetails;
		
		private EntityRef<GlAccount> _GlAccount1;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIdChanging(int value);
    partial void OnIdChanged();
    partial void OnNumberChanging(string value);
    partial void OnNumberChanged();
    partial void OnDescriptionChanging(string value);
    partial void OnDescriptionChanged();
    partial void OnAccountTypeIdChanging(System.Nullable<int> value);
    partial void OnAccountTypeIdChanged();
    partial void OnBalanceTypeIdChanging(System.Nullable<int> value);
    partial void OnBalanceTypeIdChanged();
    partial void OnConsolidateToAccountIdChanging(System.Nullable<int> value);
    partial void OnConsolidateToAccountIdChanged();
    #endregion
		
		public GlAccount()
		{
			this._GlAccounts = new EntitySet<GlAccount>(new Action<GlAccount>(this.attach_GlAccounts), new Action<GlAccount>(this.detach_GlAccounts));
			this._GlAccountDetails = new EntitySet<GlAccountDetail>(new Action<GlAccountDetail>(this.attach_GlAccountDetails), new Action<GlAccountDetail>(this.detach_GlAccountDetails));
			this._GlAccount1 = default(EntityRef<GlAccount>);
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", DbType="Int NOT NULL", IsPrimaryKey=true)]
		public int Id
		{
			get
			{
				return this._Id;
			}
			set
			{
				if ((this._Id != value))
				{
					this.OnIdChanging(value);
					this.SendPropertyChanging();
					this._Id = value;
					this.SendPropertyChanged("Id");
					this.OnIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Number", DbType="VarChar(50) NOT NULL", CanBeNull=false)]
		public string Number
		{
			get
			{
				return this._Number;
			}
			set
			{
				if ((this._Number != value))
				{
					this.OnNumberChanging(value);
					this.SendPropertyChanging();
					this._Number = value;
					this.SendPropertyChanged("Number");
					this.OnNumberChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Description", DbType="VarChar(50)")]
		public string Description
		{
			get
			{
				return this._Description;
			}
			set
			{
				if ((this._Description != value))
				{
					this.OnDescriptionChanging(value);
					this.SendPropertyChanging();
					this._Description = value;
					this.SendPropertyChanged("Description");
					this.OnDescriptionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_AccountTypeId", DbType="Int")]
		public System.Nullable<int> AccountTypeId
		{
			get
			{
				return this._AccountTypeId;
			}
			set
			{
				if ((this._AccountTypeId != value))
				{
					this.OnAccountTypeIdChanging(value);
					this.SendPropertyChanging();
					this._AccountTypeId = value;
					this.SendPropertyChanged("AccountTypeId");
					this.OnAccountTypeIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_BalanceTypeId", DbType="Int")]
		public System.Nullable<int> BalanceTypeId
		{
			get
			{
				return this._BalanceTypeId;
			}
			set
			{
				if ((this._BalanceTypeId != value))
				{
					this.OnBalanceTypeIdChanging(value);
					this.SendPropertyChanging();
					this._BalanceTypeId = value;
					this.SendPropertyChanged("BalanceTypeId");
					this.OnBalanceTypeIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ConsolidateToAccountId", DbType="Int")]
		public System.Nullable<int> ConsolidateToAccountId
		{
			get
			{
				return this._ConsolidateToAccountId;
			}
			set
			{
				if ((this._ConsolidateToAccountId != value))
				{
					if (this._GlAccount1.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnConsolidateToAccountIdChanging(value);
					this.SendPropertyChanging();
					this._ConsolidateToAccountId = value;
					this.SendPropertyChanged("ConsolidateToAccountId");
					this.OnConsolidateToAccountIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="GlAccount_GlAccount", Storage="_GlAccounts", ThisKey="Id", OtherKey="ConsolidateToAccountId")]
		public EntitySet<GlAccount> GlAccounts
		{
			get
			{
				return this._GlAccounts;
			}
			set
			{
				this._GlAccounts.Assign(value);
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="GlAccount_GlAccountDetail", Storage="_GlAccountDetails", ThisKey="Id", OtherKey="GlAccountId")]
		public EntitySet<GlAccountDetail> GlAccountDetails
		{
			get
			{
				return this._GlAccountDetails;
			}
			set
			{
				this._GlAccountDetails.Assign(value);
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="GlAccount_GlAccount", Storage="_GlAccount1", ThisKey="ConsolidateToAccountId", OtherKey="Id", IsForeignKey=true)]
		public GlAccount GlAccount1
		{
			get
			{
				return this._GlAccount1.Entity;
			}
			set
			{
				GlAccount previousValue = this._GlAccount1.Entity;
				if (((previousValue != value) 
							|| (this._GlAccount1.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._GlAccount1.Entity = null;
						previousValue.GlAccounts.Remove(this);
					}
					this._GlAccount1.Entity = value;
					if ((value != null))
					{
						value.GlAccounts.Add(this);
						this._ConsolidateToAccountId = value.Id;
					}
					else
					{
						this._ConsolidateToAccountId = default(Nullable<int>);
					}
					this.SendPropertyChanged("GlAccount1");
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
		
		private void attach_GlAccounts(GlAccount entity)
		{
			this.SendPropertyChanging();
			entity.GlAccount1 = this;
		}
		
		private void detach_GlAccounts(GlAccount entity)
		{
			this.SendPropertyChanging();
			entity.GlAccount1 = null;
		}
		
		private void attach_GlAccountDetails(GlAccountDetail entity)
		{
			this.SendPropertyChanging();
			entity.GlAccount = this;
		}
		
		private void detach_GlAccountDetails(GlAccountDetail entity)
		{
			this.SendPropertyChanging();
			entity.GlAccount = null;
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.GlAccountDetail")]
	public partial class GlAccountDetail : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _Id;
		
		private System.Nullable<int> _GlAccountId;
		
		private System.Nullable<short> _FiscalYear;
		
		private System.Nullable<short> _FiscalPeriod;
		
		private System.Nullable<decimal> _Actual;
		
		private System.Nullable<decimal> _Budget;
		
		private EntityRef<GlAccount> _GlAccount;
		
		private EntityRef<SmPeriodConversion> _SmPeriodConversion;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIdChanging(int value);
    partial void OnIdChanged();
    partial void OnGlAccountIdChanging(System.Nullable<int> value);
    partial void OnGlAccountIdChanged();
    partial void OnFiscalYearChanging(System.Nullable<short> value);
    partial void OnFiscalYearChanged();
    partial void OnFiscalPeriodChanging(System.Nullable<short> value);
    partial void OnFiscalPeriodChanged();
    partial void OnActualChanging(System.Nullable<decimal> value);
    partial void OnActualChanged();
    partial void OnBudgetChanging(System.Nullable<decimal> value);
    partial void OnBudgetChanged();
    #endregion
		
		public GlAccountDetail()
		{
			this._GlAccount = default(EntityRef<GlAccount>);
			this._SmPeriodConversion = default(EntityRef<SmPeriodConversion>);
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", AutoSync=AutoSync.OnInsert, DbType="Int NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true)]
		public int Id
		{
			get
			{
				return this._Id;
			}
			set
			{
				if ((this._Id != value))
				{
					this.OnIdChanging(value);
					this.SendPropertyChanging();
					this._Id = value;
					this.SendPropertyChanged("Id");
					this.OnIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_GlAccountId", DbType="Int")]
		public System.Nullable<int> GlAccountId
		{
			get
			{
				return this._GlAccountId;
			}
			set
			{
				if ((this._GlAccountId != value))
				{
					if (this._GlAccount.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnGlAccountIdChanging(value);
					this.SendPropertyChanging();
					this._GlAccountId = value;
					this.SendPropertyChanged("GlAccountId");
					this.OnGlAccountIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FiscalYear", DbType="SmallInt")]
		public System.Nullable<short> FiscalYear
		{
			get
			{
				return this._FiscalYear;
			}
			set
			{
				if ((this._FiscalYear != value))
				{
					if (this._SmPeriodConversion.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnFiscalYearChanging(value);
					this.SendPropertyChanging();
					this._FiscalYear = value;
					this.SendPropertyChanged("FiscalYear");
					this.OnFiscalYearChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FiscalPeriod", DbType="SmallInt")]
		public System.Nullable<short> FiscalPeriod
		{
			get
			{
				return this._FiscalPeriod;
			}
			set
			{
				if ((this._FiscalPeriod != value))
				{
					if (this._SmPeriodConversion.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnFiscalPeriodChanging(value);
					this.SendPropertyChanging();
					this._FiscalPeriod = value;
					this.SendPropertyChanged("FiscalPeriod");
					this.OnFiscalPeriodChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Actual", DbType="Decimal(38,19)")]
		public System.Nullable<decimal> Actual
		{
			get
			{
				return this._Actual;
			}
			set
			{
				if ((this._Actual != value))
				{
					this.OnActualChanging(value);
					this.SendPropertyChanging();
					this._Actual = value;
					this.SendPropertyChanged("Actual");
					this.OnActualChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Budget", DbType="Decimal(38,19)")]
		public System.Nullable<decimal> Budget
		{
			get
			{
				return this._Budget;
			}
			set
			{
				if ((this._Budget != value))
				{
					this.OnBudgetChanging(value);
					this.SendPropertyChanging();
					this._Budget = value;
					this.SendPropertyChanged("Budget");
					this.OnBudgetChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="GlAccount_GlAccountDetail", Storage="_GlAccount", ThisKey="GlAccountId", OtherKey="Id", IsForeignKey=true)]
		public GlAccount GlAccount
		{
			get
			{
				return this._GlAccount.Entity;
			}
			set
			{
				GlAccount previousValue = this._GlAccount.Entity;
				if (((previousValue != value) 
							|| (this._GlAccount.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._GlAccount.Entity = null;
						previousValue.GlAccountDetails.Remove(this);
					}
					this._GlAccount.Entity = value;
					if ((value != null))
					{
						value.GlAccountDetails.Add(this);
						this._GlAccountId = value.Id;
					}
					else
					{
						this._GlAccountId = default(Nullable<int>);
					}
					this.SendPropertyChanged("GlAccount");
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="SmPeriodConversion_GlAccountDetail", Storage="_SmPeriodConversion", ThisKey="FiscalYear,FiscalPeriod", OtherKey="FiscalYear,FiscalPeriod", IsForeignKey=true)]
		public SmPeriodConversion SmPeriodConversion
		{
			get
			{
				return this._SmPeriodConversion.Entity;
			}
			set
			{
				SmPeriodConversion previousValue = this._SmPeriodConversion.Entity;
				if (((previousValue != value) 
							|| (this._SmPeriodConversion.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._SmPeriodConversion.Entity = null;
						previousValue.GlAccountDetails.Remove(this);
					}
					this._SmPeriodConversion.Entity = value;
					if ((value != null))
					{
						value.GlAccountDetails.Add(this);
						this._FiscalYear = value.FiscalYear;
						this._FiscalPeriod = value.FiscalPeriod;
					}
					else
					{
						this._FiscalYear = default(Nullable<short>);
						this._FiscalPeriod = default(Nullable<short>);
					}
					this.SendPropertyChanged("SmPeriodConversion");
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.SmPeriodConversion")]
	public partial class SmPeriodConversion : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _Id;
		
		private System.Nullable<short> _FiscalYear;
		
		private System.Nullable<short> _FiscalPeriod;
		
		private System.Nullable<System.DateTime> _FromDate;
		
		private System.Nullable<System.DateTime> _ThruDate;
		
		private System.Nullable<bool> _GlClosed;
		
		private System.Nullable<bool> _ApClosed;
		
		private System.Nullable<bool> _ArClosed;
		
		private EntitySet<GlAccountDetail> _GlAccountDetails;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIdChanging(int value);
    partial void OnIdChanged();
    partial void OnFiscalYearChanging(System.Nullable<short> value);
    partial void OnFiscalYearChanged();
    partial void OnFiscalPeriodChanging(System.Nullable<short> value);
    partial void OnFiscalPeriodChanged();
    partial void OnFromDateChanging(System.Nullable<System.DateTime> value);
    partial void OnFromDateChanged();
    partial void OnThruDateChanging(System.Nullable<System.DateTime> value);
    partial void OnThruDateChanged();
    partial void OnGlClosedChanging(System.Nullable<bool> value);
    partial void OnGlClosedChanged();
    partial void OnApClosedChanging(System.Nullable<bool> value);
    partial void OnApClosedChanged();
    partial void OnArClosedChanging(System.Nullable<bool> value);
    partial void OnArClosedChanged();
    #endregion
		
		public SmPeriodConversion()
		{
			this._GlAccountDetails = new EntitySet<GlAccountDetail>(new Action<GlAccountDetail>(this.attach_GlAccountDetails), new Action<GlAccountDetail>(this.detach_GlAccountDetails));
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", DbType="Int NOT NULL", IsPrimaryKey=true)]
		public int Id
		{
			get
			{
				return this._Id;
			}
			set
			{
				if ((this._Id != value))
				{
					this.OnIdChanging(value);
					this.SendPropertyChanging();
					this._Id = value;
					this.SendPropertyChanged("Id");
					this.OnIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FiscalYear", DbType="SmallInt")]
		public System.Nullable<short> FiscalYear
		{
			get
			{
				return this._FiscalYear;
			}
			set
			{
				if ((this._FiscalYear != value))
				{
					this.OnFiscalYearChanging(value);
					this.SendPropertyChanging();
					this._FiscalYear = value;
					this.SendPropertyChanged("FiscalYear");
					this.OnFiscalYearChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FiscalPeriod", DbType="SmallInt")]
		public System.Nullable<short> FiscalPeriod
		{
			get
			{
				return this._FiscalPeriod;
			}
			set
			{
				if ((this._FiscalPeriod != value))
				{
					this.OnFiscalPeriodChanging(value);
					this.SendPropertyChanging();
					this._FiscalPeriod = value;
					this.SendPropertyChanged("FiscalPeriod");
					this.OnFiscalPeriodChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FromDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> FromDate
		{
			get
			{
				return this._FromDate;
			}
			set
			{
				if ((this._FromDate != value))
				{
					this.OnFromDateChanging(value);
					this.SendPropertyChanging();
					this._FromDate = value;
					this.SendPropertyChanged("FromDate");
					this.OnFromDateChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ThruDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> ThruDate
		{
			get
			{
				return this._ThruDate;
			}
			set
			{
				if ((this._ThruDate != value))
				{
					this.OnThruDateChanging(value);
					this.SendPropertyChanging();
					this._ThruDate = value;
					this.SendPropertyChanged("ThruDate");
					this.OnThruDateChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_GlClosed", DbType="Bit")]
		public System.Nullable<bool> GlClosed
		{
			get
			{
				return this._GlClosed;
			}
			set
			{
				if ((this._GlClosed != value))
				{
					this.OnGlClosedChanging(value);
					this.SendPropertyChanging();
					this._GlClosed = value;
					this.SendPropertyChanged("GlClosed");
					this.OnGlClosedChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ApClosed", DbType="Bit")]
		public System.Nullable<bool> ApClosed
		{
			get
			{
				return this._ApClosed;
			}
			set
			{
				if ((this._ApClosed != value))
				{
					this.OnApClosedChanging(value);
					this.SendPropertyChanging();
					this._ApClosed = value;
					this.SendPropertyChanged("ApClosed");
					this.OnApClosedChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ArClosed", DbType="Bit")]
		public System.Nullable<bool> ArClosed
		{
			get
			{
				return this._ArClosed;
			}
			set
			{
				if ((this._ArClosed != value))
				{
					this.OnArClosedChanging(value);
					this.SendPropertyChanging();
					this._ArClosed = value;
					this.SendPropertyChanged("ArClosed");
					this.OnArClosedChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="SmPeriodConversion_GlAccountDetail", Storage="_GlAccountDetails", ThisKey="FiscalYear,FiscalPeriod", OtherKey="FiscalYear,FiscalPeriod")]
		public EntitySet<GlAccountDetail> GlAccountDetails
		{
			get
			{
				return this._GlAccountDetails;
			}
			set
			{
				this._GlAccountDetails.Assign(value);
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
		
		private void attach_GlAccountDetails(GlAccountDetail entity)
		{
			this.SendPropertyChanging();
			entity.SmPeriodConversion = this;
		}
		
		private void detach_GlAccountDetails(GlAccountDetail entity)
		{
			this.SendPropertyChanging();
			entity.SmPeriodConversion = null;
		}
	}
}
#pragma warning restore 1591
